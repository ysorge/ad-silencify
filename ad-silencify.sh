#!/bin/bash

ad_playing=0
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '{print $2}' | awk '{print $1}')

while true; do

    # Check the metadata of the currently playing song on Spotify
    output=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata)

    # Check if an advertisement URL of Spotify is in the output
    status=$( echo $output | grep "spotify.com/ad/" | wc -l )

    # If advertisement is playing, mute system sound
    if [ "$status" -gt 0 ]; then
        if [ "$ad_playing" -eq 0 ]; then
            ad_playing=1
            volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '{print $2}' | awk '{print $1}')
            pactl set-sink-volume @DEFAULT_SINK@ 0%
            notify-send "Ad detected :(" "Muted"
        fi
    fi
    
    # If advertisement is over, increase volume to previous value
    if [ "$status" -lt 1 ]; then
    	if [ "$ad_playing" -eq 1 ]; then
		pactl set-sink-volume @DEFAULT_SINK@ $volume
	    	ad_playing=0
	    	notify-send "Ad gone \o/" "Volume increased"
	    	#zenity --info --text="Advertisement stopped" --timeout=5
	fi
    fi

    sleep 1
done
