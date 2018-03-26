#!/bin/bash
ON=0
OFF=1
status=`synclient -l | grep TouchpadOff | grep -c $OFF`
if [ $status == $OFF ]
then synclient TouchpadOff=$ON
else synclient TouchpadOff=$OFF
fi