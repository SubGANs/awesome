#!/usr/bin/sh
test `xset -q | grep LED | awk {' print $10 '} | cut -c5` -eq 1 && echo "Рус" || echo "Eng"
