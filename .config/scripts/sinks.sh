#!/bin/sh
# create 3 virtual sinks that i can route shit through for mixing
pactl load-module module-null-sink media.class=Audio/Sink sink_name=nullsink channel_map=stereo
pactl load-module module-null-sink media.class=Audio/Sink sink_name=media-sink channel_map=stereo
pactl load-module module-null-sink media.class=Audio/Sink sink_name=vc-sink channel_map=stereo

#nullsink is the 'everything' sink for me
pactl set-default-sink nullsink
