# Recompiles the streamio controls plugin whenever a new graphics swf is exported

require 'bundler/setup'
Bundler.require

fsevent = FSEvent.new
fsevent.watch "#{Dir.pwd}/plugins/controls/src/flash/streamio", latency: 2 do |dirs|
  puts "#{Time.now} - Recompiling!"
  system "ant -f plugins/controls/build-streamio.xml"
  system "cp plugins/controls/build/flowplayer.controls-streamio* site/content/swf"
  system "growlnotify -m 'Skin recompiled!'"
end

puts "Listening to changes at plugins/controls/src/flash/streamio"

fsevent.run
