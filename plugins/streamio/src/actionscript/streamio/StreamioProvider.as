package streamio {
  import org.flowplayer.model.*
  import org.flowplayer.view.*
  import org.flowplayer.controller.*
  import org.flowplayer.util.*

  import flash.net.*
  import flash.events.*

  import com.adobe.serialization.json.*

  public class StreamioProvider extends NetStreamControllingStreamProvider {
    private var pluginModel:PluginModel
    private var config:Object
    private var connectArgs:Array
    private var video:Object

    // Availible config:
    // *videoId:String
    // ssl:Boolean[true]
    // host:String[streamio.com]
    // analyticsChannel:String[streamio]
    override public function onConfig(pluginModel:PluginModel):void {
      this.pluginModel = pluginModel

      config = model.config
      if(config.ssl == null) config.ssl = true
      if(config.host == null) config.host = "streamio.com"
      if(config.analyticsChannel == null) config.analyticsChannel == "streamio"
      
      log.info("received config ", config)
    }

    override public function onLoad(player:Flowplayer):void {
      trackAnalyticsEvent("view")

      player.playlist.onStart(function(event:ClipEvent) { trackAnalyticsEvent("play") })

      pluginModel.dispatchOnLoad()
    }

    override protected function connect(clip:Clip, ... rest):void {
      connectArgs = rest
      connectArgs.unshift(clip)
      loadStreamioVideo()
    }

    override protected function getClipUrl(clip:Clip):String {
      return protocol + video.transcodings[0].http_uri as String
    }

    private function loadStreamioVideo():void {
      var loader:URLLoader = new URLLoader
      loader.addEventListener(Event.COMPLETE, onUrlLoaded)
      loader.load(new URLRequest(apiBase + "/videos/" + config.videoId + "/public_show.json"))
    }

    private function onUrlLoaded(event:Event):void {
      var loader:URLLoader = event.target as URLLoader

      video = JSON.decode(loader.data)

      log.info("received streamio video ", video)

      super.connect.apply(this, connectArgs)
    }

    private function trackAnalyticsEvent(event:String) {
      var loader:URLLoader = new URLLoader

      var params:URLVariables = new URLVariables
      params.video_id = config.videoId
      params.channel = config.analyticsChannel
      params.event = event

      var request:URLRequest = new URLRequest(apiBase+"/stats")
      request.method = "POST"
      request.data = params
      
      loader.load(request)
    }

    private function get apiBase():String { return protocol + config.host + "/api/v1" }

    private function get protocol():String { return config.ssl ? "https://" : "http://" }
  }
}