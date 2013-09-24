# Flowplayer Flash

## Streamio Edition

At Streamio we use Flowplayer for compatiblility with facebook opengraph video. Be aware that this version of Flowplayer is not as fully featured as our own GoPlayer.

## Building

Download [Flex SDK 4.5.1](http://fpdownload.adobe.com/pub/flex/sdk/builds/flex4.5/flex_sdk_4.5.1.21328A.zip).

Make sure to have FLEX_HOME set to your flex installation directory and FLEX_HOME/bin in your execution path (we need mxmlc to be available etc).

Then follow [the original instructions](http://flowplayer.org/documentation/developer/development-environment.html).

### Build Skin

There is a ruby script available to re-compile the streamio skin whenever files are changed.

```bash
bundle # if you need to install dependencies
ruby auto-recompile.rb
```

## License

The Flowplayer Free version is released under the
GNU GENERAL PUBLIC LICENSE Version 3 (GPL).

The GPL requires that you not remove the Flowplayer copyright notices
from the user interface. [http://flowplayer.org/download/licenses/license_gpl.html](See section 5.d here).

Commercial licenses are available. The commercial player version
does not require any Flowplayer notices or texts and also provides
some additional features.

Copyright (c) 2012 Flowplayer Ltd
