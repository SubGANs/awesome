#!/bin/bash
# Будильник с использованием Audacious

# {{{ Проверка указанного времени
# Если не указано время
if [[ $# -le 0 ]]
then 
	echo 'Установите правильное время. Пример: "07:00".'
	DISPLAY=:0.0 notify-send 'SnakyAlarm' 'Установите правильное время. Пример: "07:00".'
	exit 1
fi
# Если много параметров
if [[ $# > 1 ]]
then 
	echo 'Установите правильное время. Пример: "07:00".'
	DISPLAY=:0.0 notify-send 'SnakyAlarm' 'Установите правильное время. Пример: "07:00".'
	exit 1
fi
# Проверка формата времени
if [[ $# == 1 ]]
then
	if [[ "$1" != [0-9][0-9]:[0-9][0-9] ]]
	then
		echo 'Установите правильное время. Пример: "07:00".'
		DISPLAY=:0.0 notify-send 'SnakyAlarm' 'Установите правильное время. Пример: "07:00".'
		exit 1
	fi
fi
# }}}

# Опопвещение
# {{{
if [[ ${1:0:2} -ge `date +%H` ]]
then
	echo "Будильник сработает сегодня в $1"
	DISPLAY=:0.0 notify-send 'SnakyAlarm' "Будильник сработает сегодня в $1"
	zenity --info --text="Будильник сработает сегодня в $1" --no-wrap
else
	echo "Будильник сработает завтра в $1"
	DISPLAY=:0.0 notify-send 'SnakyAlarm' "Будильник сработает завтра в $1"
	zenity --info --text="Будильник сработает завтра в $1" --no-wrap
fi
# }}}

# Ждем указанное время
while [[ $1 != `date +%H:%M` ]]
do
	sleep 30s
done


# Убавляем звук
sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 10%'
#amixer set Master 70% unmute &> /dev/null
# Запускаем музыку
audacious --fwd --play &
# Прибавляем звук
for ((a=1; a <= 14 ; a++))
do
  sh -c 'pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +2%'
  #amixer set Master 2%+ unmute &> /dev/null
  sleep 2
done

echo 'С добрым утром! :)'
DISPLAY=:0.0 notify-send 'SnakyAlarm' 'С добрым утром :)'
# Успешный выход
exit 0
