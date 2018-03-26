#!/bin/bash

#Доступ к Яндекс.Диск'у
# {{{
source ${HOME}/.config/awesome/scripts/scripts.conf
login=$YANDEX_LOGIN
password=$YANDEX_PASSWORD
# }}}

# Настройки
# {{{
save_dir="${HOME}/Screenshots/" # Директория для локального сохранения
ya_save_dir="Screenshots/" # Директория на Яндекс.Диске для хранения (пустое значение - корень диска)
xml_dir="${HOME}/.config/awesome/scripts/ya_xml.txt" # Директория xml для публикации файла
# }}}

# Создание скриншота
# {{{
date_screen="$(date +%d-%m-%Y_%H:%M:%S)" # Дата создания скрина
name="screen-$date_screen.jpg" # Имя скрина
if ! import -window root $save_dir/$name
then
	DISPLAY=:0.0 notify-send "YaScreen" "Не удалось создать скриншот"
	exit 1
fi
# }}}

# Копирование скрина на Яндекс диск
# {{{
if ! curl -T $save_dir/$name --user $login:$password https://webdav.yandex.ru/$ya_save_dir
then
	DISPLAY=:0.0 notify-send "YaScreen" "Не удалось скопировать файл на Яндекс.Диск"
	exit 1
fi
# }}}

# Получить ссылку на скрин
# {{{
if ! get_url=`curl --user $login:$password -X PROPPATCH -H "Content-Type: text/xml" --data-binary "@$xml_dir" https://webdav.yandex.ru/$ya_save_dir$name | grep -o "https://[a-zA-Z+.-]*/[a-zA-Z0-9.+-]*/[a-zA-Z0-9_+-]*"`
then
	DISPLAY=:0.0 notify-send "YaScreen" "Не удалось получить ссылку на скриншот"
	exit 1
else
	echo $get_url | xclip -i -selection clipboard # Скопировать ссылку в буфер обмена
	DISPLAY=:0.0 notify-send "YaScreen" "Ссылка на скриншот скопирована в буфер обмена" # Вывод сообщения о копировании
	exit 0
fi
# }}}