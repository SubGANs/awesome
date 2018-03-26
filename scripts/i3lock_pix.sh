#!/bin/bash

scrot /tmp/screen_lock.png
mogrify -scale 10% -scale 1000% /tmp/screen_lock.png
i3lock -i /tmp/screen_lock.png
