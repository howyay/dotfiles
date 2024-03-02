#!/bin/sh
file=$(
	hyprpicker -r -z &
	sleep 0.1s
	grimblast save area
	pkill hyprpicker
)
if [ -z "$file" ]; then
	if [ ! -f /tmp/SCREENSHOT_CANCELLED_NOTIF_ID ]; then
		notify-send 'Screenshot cancelled' -t 1000 -e -p >/tmp/SCREENSHOT_CANCELLED_NOTIF_ID
	else
		notify-send 'Screenshot cancelled' -t 1000 -e -p -r $(</tmp/SCREENSHOT_CANCELLED_NOTIF_ID) >/tmp/SCREENSHOT_CANCELLED_NOTIF_ID
	fi
	exit 0
fi
#editedFile=$file
action=$(notify-send 'Screenshot saved' -i $file -A copy=Copy -A edit=Edit)
if [ "$action" = "edit" ]; then
	satty -f "$file" --output-filename "$file" &
elif [ "$action" = "copy" ]; then
	wl-copy -t image/png <$file &
#else
#	satty -f "$file" --output-filename "$editedFile" &
fi
