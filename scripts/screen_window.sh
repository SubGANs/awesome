#!/bin/bash

# Нужны следующие утилиты: xclip, flameshot

###################
#### Настройки ####
###################

# Доступ к Яндекс.Диск'у
source $HOME/.config/awesome/scripts/scripts.conf # Если нет файла конфига, то просто вписать ниже данные доступа, а эту строку удалить

login=$YANDEX_LOGIN
password=$YANDEX_PASSWORD

# Где локальном будем хранить скриншоты
SAVE_DIR="$HOME/Screenshots/" # Директория для локального сохранения
YA_SAVE_DIR="Screenshots/" # Директория на Яндекс.Диске для хранения (пустое значение - корень диска)


XML_DIR="$HOME/.config/awesome/scripts/ya_xml.txt" # Директория xml для публикации файла


######################
#### Делаем скрин ####
######################


# Берем патерн имени скрипта из файла настроек flameshot
patt_name=`grep filenamePattern ~/.config/Dharkael/flameshot.ini | awk -F "=" '{print $2}'`

name=`date +$patt_name` # Имя скрина

flameshot config -f $name # задаем имя скрину

# Делаем скрин
if ! flameshot gui -p $SAVE_DIR -r > /tmp/$name.png
then
	DISPLAY=:0.0 notify-send "YaScreen" "Не удалось создать скриншот"
  # Удаляем временный скрин
  rm -f /tmp/$name.png
  # Возвращаем имя патерна на прежнее
  flameshot config -f $patt_name
	exit 1
fi

# Если отменили создание скриншота, то выходим из скрипта
if grep "screenshot failed" /tmp/$name.png
then
  # Удаляем временный скрин
  rm -f /tmp/$name.png
  # Возвращаем имя патерна на прежнее
  flameshot config -f $patt_name
  #sed -si "s|$name|$patt_name|g" ~/.config/Dharkael/flameshot.ini
  exit 1
fi

# Возвращаем имя патерна на прежнее
flameshot config -f $patt_name

# Копирование скрина на Яндекс диск
if ! curl -T /tmp/$name.png --user $login:$password https://webdav.yandex.ru/$YA_SAVE_DIR
then
	DISPLAY=:0.0 notify-send "YaScreen" "Не удалось скопировать файл на Яндекс.Диск"
  # Удаляем временный скрин
  rm -f /tmp/$name.png
	exit 1
fi

# Удаляем временный скрин
rm -f /tmp/$name.png

# Получить ссылку на скрин
if ! get_url=`curl --user $login:$password -X PROPPATCH -H "Content-Type: text/xml" --data-binary "@$XML_DIR" https://webdav.yandex.ru/$YA_SAVE_DIR$name.png | grep -o "https://[a-zA-Z+.-]*/[a-zA-Z0-9.+-]*/[a-zA-Z0-9_+-]*"`
then
	DISPLAY=:0.0 notify-send "YaScreen" "Не удалось получить ссылку на скриншот"
	exit 1
else
	echo $get_url | xclip -i -selection clipboard # Скопировать ссылку в буфер обмена
	DISPLAY=:0.0 notify-send "YaScreen" "Ссылка на скриншот скопирована в буфер обмена" # Вывод сообщения о копировании
	exit 0
fi


