#!/bin/sh
# restarting hyprland creates multiple sinks so we check
# to make sure we dont re-create the sinks and end up with dupes
create_sink_idempotent() {
    name="$1"
    shift
    if ! pactl list short sinks | awk '{print $2}' | grep -qx "$name"; then
        echo "Creating sink: $name"
        pactl load-module module-null-sink "$@" sink_name="$name" channel_map=stereo
    else
        echo "Sink already exists: $name"
    fi
}

create_sink_idempotent nullsink media.class=Audio/Sink
create_sink_idempotent media-sink media.class=Audio/Sink
create_sink_idempotent vc-sink media.class=Audio/Sink

pactl set-default-sink nullsink

