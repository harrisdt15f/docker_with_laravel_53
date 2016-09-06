> Hi, 各位有 follow 我的 repo 們，跟大家報告最近的動態。先講結論，這幾天我忙著將 ubuntu base 改為 alpine base終於在昨天完成了，謝謝 Miles Chou 和 其它網友大大的協助。 不過我並沒有釋出，我想了大半天我不釋出的原因，雖然整體容量僅佔 300MB，但我不想成為一位獨行俠，因此我重新看過一次 賴冠呈 推薦的 laradock ，它也是目前廣為流行的 docker laravel 環境，雖然整體來說容量重很多，但它也包山包海，只要謹慎調整其實也在容忍範圍之間，實在是很好的開發環境。
謝謝大家近日來的詢問和建議，目前 我的 repo 對 laravel5 來說還是很棒的入門環境，但對比未來，或許 Laradock 作者也會精緻化他的作業系統(images)，此後我不會再更新這支 repo 了，謝謝。
需要技術討論的人，歡迎加我 [facebook](https://www.facebook.com/yiminghsu)

# Docker with Laravel 5.3 + Supervisor

歡迎 fork 去用  :)  路過歡迎給顆星★

> 因為還沒完全了解 Laravel 5.3 未來會持續優化

## 索引大綱

1. 專案包含配備 - what is it included in the package.
1. 專案安裝 - how to install the package.
1. 設定開發環境 - Develop environment set.

## 專案包含配備(include)

1. Docker base
1. Nginx
1. MySQL Server
1. Redis Server
1. Laravel 5.3 (with PHP7.0, Scheduling)
1. Supervisor

## 專案安裝(install)

1. 首先，要先安裝 docker 和 docker-compose
1. 編輯 {專案根目錄}/.env ( `$ cp -n .env.example .env` )
1. 編輯 {專案根目錄}/www/html/.env ( `$ cp -n .env.example .env` )
1. 建置專案 `$ docker-compose build`
1. 執行專案 `$ docker-compose up -d`

> 記得在 /etc/hosts 加入 "127.0.0.1 app"，接著就能在 bowser url 使用 http://app.docker 查看 Laravel 5.3 首頁了 :)

## 設定開發環境

仔細看會發現 `{專案根目錄}/www/html/Dockerfile` 會將 Laravel 目錄拷貝到 contianer 裡，

因此程式無法即時變更(唯讀)，這麼做的目的是要提升專案執行效率。

> 如果 docker 開啟 volumes 會讓程式執行效率變慢

為了方便開發者能即時選寫 laravel 程式，請編輯 `{專案根目錄}/docker-compose.yml`

```
$ cd {專案根目錄}
$ vim docker-compose.yml
app:
  build: ./www
  container_name: app
  restart: always
  ports:
    - "80:80" # web
  links:
    - database:database
  volumes:                   // <----- 將 # 移除
    - ./www:/var/www         // <----- 將 # 移除
```

然後，安裝 composer vendor

```
$ cd {專案根目錄}/www/html
$ composer install
```

最後，重新啟動 container

```
$ cd {專案根目錄}
$ docker-compose up -d
```
