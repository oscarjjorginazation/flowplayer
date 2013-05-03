package streamio {
  import org.flowplayer.model.*
  import org.flowplayer.view.*
  import org.flowplayer.util.*

  import flash.net.*
  import flash.display.Sprite

  public class StreamioPlugin extends Sprite implements Plugin {
    private var pluginModel:PluginModel
    private var player:Flowplayer
    private var config:Object
    private var apiBase:String

    private const log:Log = new Log(this)
    private const loader:URLLoader = new URLLoader

    public function StreamioPlugin() {}

    /**
     * Provides plugins their configuration properties.
     * This happens when the plugin SWF has been loaded but
     * before it is added to the display list.
     *
     * An instance of a PluginModel is passed. This instance provides access to the configuration
     * options among other things.
     *
     * @param model the plugin model
     */
    public function onConfig(pluginModel:PluginModel):void {
      this.pluginModel = pluginModel
      config = pluginModel.config

      apiBase = (config.ssl ? "https://" : "http://") + config.host + "/api/v1"

      log.info("received config ", config);
    }

    /**
     * Called when the player has been initialized. The interface is immediately ready to use, all
     * other plugins have been loaded and initialized when this gets called.
     *
     * After this method has been called the plugin will be placed on the stage (on
     * player's Panel).
     */
    public function onLoad(player:Flowplayer):void {
      var playlist:Playlist = player.playlist

      trackEvent("view")

      playlist.onStart(function(event:ClipEvent) { trackEvent("play") })

      pluginModel.dispatchOnLoad()
    }

    /**
     * Gets the default configuration to be used for this plugin. Called after onConfig() but
     * before onLoad()
     * @return default configuration object, <code>null</code> if no defaults are available
     */
    public function getDefaultConfig():Object {
      return {
        ssl: true,
        host: "streamio.com",
        videoId: null
      }
    }

    private function trackEvent(event:String) {
      var params:URLVariables = new URLVariables
      params.video_id = config.videoId
      params.channel = "facebook"
      params.event = event

      var request:URLRequest = new URLRequest(apiBase+"/stats")
      request.method = "POST"
      request.data = params
      
      loader.load(request)
    }
  }
}
