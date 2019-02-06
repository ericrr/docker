FROM debian

MAINTAINER Eric Roberto

RUN apt-get update && apt-get install -y apache2 && apt-get clean

ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV apache_log_dir="/var/log/apache2"

LABEL Description="WebServer"

VOLUME /var/www/html

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
