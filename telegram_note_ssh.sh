#!/bin/bash
# Telegram notification
# Send msg when your server load to high
token="_TOKEN_" # put your token here 
chat_id="_CHAT_ID_" # your chat_id for sending notification
sendmsg="https://api.telegram.org/bot$token/sendMessage?parse_mode=markdown" # url for sending msg
sendfile="https://api.telegram.org/bot$token/sendDocument?parse_mode=markdown" # url for sending files
date="$(date "+%d-%b-%Y-%H:%M")"
caption_file=/tmp/ssh_caption_file.txt
msg=/tmp/ssh_msg_info.txt
curl http://ip-api.com/json/$PAM_RHOST -s -o $caption_file #take info about new connection
country=$(cat $caption_file | jq '.country' | sed 's/"//g')
city=$(cat $caption_file | jq '.city' | sed 's/"//g')
org=$(cat $caption_file | jq '.as' | sed 's/"//g')
echo -e "🆘**New SSH login**🆘\n*🥷🏻$PAM_USER* logged in on server *$HOSTNAME*\n at $date \nfrom IP: $PAM_RHOST\n-Country:*$country*\n-City=*$city*\n-Organisation=*$org*" > $msg
curl $sendmsg -d chat_id=$chat_id -d text="$(<$msg)" 
rm /tmp/ssh_caption_file.txt
rm /tmp/ssh_msg_info.txt
