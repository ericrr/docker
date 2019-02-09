version: '3.4'

services:

  mysql-server:
    image: mysql:5.7
    container_name: mysql-server
    environment:
      - MYSQL_DATABASE=zabbix
      - MYSQL_USER=zabbix
      - MYSQL_PASSWORD=zabbix_pwd
      - MYSQL_ROOT_PASSWORD=root_pwd
    command: --character-set-server=utf8 --collation-server=utf8_bin
    hostname: zabbixdb

  zabbix-java:
    image: zabbix/zabbix-java-gateway
    container_name: zabbix-java-gateway

  zabbix-server:
    image: zabbix/zabbix-server-mysql:latest
    container_name: zabbix-server-mysql
    environment:
      - DB_SERVER_HOST=mysql-server
      - MYSQL_DATABASE=zabbix
      - MYSQL_USER=zabbix
      - MYSQL_PASSWORD=zabbix_pwd
      - MYSQL_ROOT_PASSWORD=root_pwd
      - ZBX_JAVAGATEWAY=zabbix-java-gateway
    links:
      - mysql-server:mysql
      - zabbix-java:zabbix-java-gateway
    ports:
      - 10051:10051
    hostname: zabbixsrv

      zabbix-web-nginx:
    image: zabbix/zabbix-web-nginx-mysql:latest
    container_name: zabbix-web-nginx-mysql
    environment:
      - DB_SERVER_HOST=mysql-server
      - MYSQL_DATABASE=zabbix
      - MYSQL_USER=zabbix
      - MYSQL_PASSWORD=zabbix_pwd
      - MYSQL_ROOT_PASSWORD=root_pwd
    links:
      - mysql-server:mysql
      - zabbix-server:zabbix-server
    ports:
      - 80:80
    hostname: zabbix-web-nginx