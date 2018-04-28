# 萌股后台

```
version: "2"

services:
  db:
   image: mysql:5.7
   volumes:
     - db_data:/var/lib/mysql
   restart: always
   environment:
     MYSQL_ROOT_PASSWORD:
     MYSQL_DATABASE:
     MYSQL_USER:
     MYSQL_PASSWORD:
  violet:
    image: registry.cn-shenzhen.aliyuncs.com/iqing/violet:v0.0.2
    ports:
      - "8080:80"
  moestock:
    image: registry.cn-shenzhen.aliyuncs.com/iqing/moestock:v0.0.1
    command:
      - run
    environment:
      DB_NAME:
      DB_USER:
      DB_PW:
      DB_HOST:
    ports:
      - "8080:80"
```
