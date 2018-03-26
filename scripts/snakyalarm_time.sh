#!/bin/sh
time=`ps x | grep "snakyalarm" | grep -o "[0-9][0-9]:[0-9][0-9]"`
echo $time