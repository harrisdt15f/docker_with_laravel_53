# Docker with Laravel 5.3 + Supervisor

歡迎 fork 去用  :)

路過歡迎給顆星

> 因為還沒完全了解 Laravel 5.3 未來會持續優化

## 專案包含配備(include)

1. Docker base
1. Nginx
1. MySQL Server
1. Laravel 5.3 (with PHP7.0, Scheduling)
1. Supervisor

## 專案安裝(install)

1. 首先，要先安裝 docker 和 docker-compose
1. 編輯 {專案根目錄}/.env ( `$ cp -n .env.example .env` )
1. 編輯 {專案根目錄}/www/html/.env ( `$ cp -n .env.example .env` )
1. 建置專案 `$ docker-compose build`
1. 執行專案 `$ docker-compose up -d`

> 記得在 /etc/hosts 加入 "127.0.0.1 app"，接著就能在 bowser url 使用 http://app.docker 查看 Laravel 5.3 首頁了 :)