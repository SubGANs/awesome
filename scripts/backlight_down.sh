#!/bin/sh
#XF86MonBrightnessDown | #232
MAX_BRIGHTNESS=4882
BRIGHTNESS_FILE='/sys/class/backlight/intel_backlight/brightness'
DIFF=500

cur_bright=`cat $BRIGHTNESS_FILE`

let "new_value=$cur_bright-$DIFF"

echo $new_value > $BRIGHTNESS_FILE | $2>/dev/null