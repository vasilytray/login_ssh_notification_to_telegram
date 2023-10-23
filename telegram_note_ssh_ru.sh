#!/bin/bash
# Telegram сообщения
# Отправляем сообщение когда на сервере новое ssh-соединение
token="_TOKEN_" # здесь разместите токен Телеграм-бота 
chat_id="_CHAT_ID_" # указите чат-id, куда отправлять сообщения
sendmsg="https://api.telegram.org/bot$token/sendMessage?parse_mode=markdown" # url для отправки сообщения на API
sendfile="https://api.telegram.org/bot$token/sendDocument?parse_mode=markdown" # url для отправки файла на API
date="$(date "+%d-%b-%Y-%H:%M")"
caption_file=/tmp/ssh_caption_file.txt
msg=/tmp/ssh_msg_info.txt
curl http://ip-api.com/json/$PAM_RHOST -s -o $caption_file #Получаем информацию о новом соединении
country=$(cat $caption_file | jq '.country' | sed 's/"//g')
city=$(cat $caption_file | jq '.city' | sed 's/"//g')
org=$(cat $caption_file | jq '.as' | sed 's/"//g')
echo -e "🆘**Новое подключение SSH **🆘\n*🥷🏻$PAM_USER *подключился к серверу *$HOSTNAME*\n at $date\n- IP подключения: $PAM_RHOST\n-Страна:*$country*\n-Город=*$city*\n-Компания=*$org*" > $msg
curl $sendmsg -d chat_id=$chat_id -d text="$(<$msg)" 
rm /tmp/ssh_caption_file.txt
rm /tmp/ssh_msg_info.txt
