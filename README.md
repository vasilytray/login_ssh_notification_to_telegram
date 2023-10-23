# login_ssh_notification_to_telegram
notification to telegram bot about new ssh login
## Как отправить уведомление в Telegram
Скрипт отправки уведомлений в телеграмм о входе на сервер по SSH

tags = ['Telegram', 'Bash', 'Bot']
image = "/posts/telegrambot-ssh.png"

Для работы скрипта Вам понадобится jq

Установка **jq** _Ubuntu / Linux Mint / Debian_
```ssh
sudo apt install jq
```
Установка **jq** *CentOS*
```ssh
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install jq
```
Установка : Копируем скрипт в /usr/local/bin/
```ssh
wget -P /usr/local/bin/ https://raw.githubusercontent.com/vasilytray/login_ssh_notification_to_telegram/main/telegram_note_ssh.sh
```
Зайдем в скрипт и добавим токен и chat_id для нашего бота
```
nano /usr/local/bin/telegram_note_ssh.sh
```
![bot-token and chat-id](/images/posts/chat_id_telegram.jpg)

Как получить chat_id для telegram_bot?
Для начала надо узнать бот-токен и для этого обратимся к @BotFather, - это бот в Telegram котрый создает ботов.  Там для своего бота узнаем токен (сообщался при создании бота)
зная токен бота узнаем ID чата. Самое простое - напишите своему боту зоть слово.
Далее в браузере отправляем запрос: 

```
https://api.telegram.org/botбот-токен/getUpdates
```

(не забудьте подставить токен бота)
в ответ получите ответ api в котором надо найти пару:

 **"chat id":123456890** - число и будет ID вашего чата.

Устанавливаем права на запуск
```
$ chmod +x /usr/local/bin/telegram_note_ssh.sh
```
Для Ubuntu В файл /etc/pam.d/common-session добавляем следующую строку
```
$ echo "session optional pam_exec.so type=open_session seteuid /usr/local/bin/telegram_note_ssh.sh" >> /etc/pam.d/common-session
```
Для CentOS В файл /etc/pam.d/sshd добавляем следующую строку
```
$ echo "session optional pam_exec.so type=open_session seteuid /usr/local/bin/telegram_note_ssh.sh" >> /etc/pam.d/common-session
```
организуем новое соединение на сервер по ssh  и получем долгожданное сообщение от бота:
![telegram-bot alert ssh-login!](/images/posts/telegram_bot_alert.jpg)

Ну если не получаем желаемого результата и убеждены, что все сделали правильно, тоооооо...

Проверяем установлен ли на сервере CURL (если нет - надо установить.), т.к. скрипт использует CURL
Проверка
```
$ curl -V
```
результат должен дать что-то подобное:

>curl 7.81.0 (x86_64-pc-linux-gnu) libcurl/7.81.0 OpenSSL/3.0.2 zlib/1.2.11 brotli/1.0.9 zstd/1.4.8 libidn2/2.3.2 libpsl/0.21.0 (+libidn2/2.3.2) libssh/0.9.6/openssl/zlib nghttp2/1.43.0 librtmp/2.3 OpenLDAP/2.5.14
Release-Date: 2022-01-05
Protocols: dict file ftp ftps gopher gophers http https imap imaps ldap ldaps mqtt pop3 pop3s rtmp rtsp scp sftp smb smbs smtp smtps telnet tftp 
Features: alt-svc AsynchDNS brotli GSS-API HSTS HTTP2 HTTPS-proxy IDN IPv6 Kerberos Largefile libz NTLM NTLM_WB PSL SPNEGO SSL TLS-SRP UnixSockets zstd
