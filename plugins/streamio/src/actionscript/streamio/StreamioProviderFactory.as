package streamio {
  import flash.display.Sprite
  import org.flowplayer.model.PluginFactory
  import streamio.StreamioProvider

  public class StreamioProviderFactory extends Sprite implements PluginFactory {
    public function newPlugin():Object {
      return new StreamioProvider()
    }
  }
}
