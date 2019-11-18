# 說明
如何在 GitHub 設定 Travis CI，以 Ruby on Rails 專案為例。  

# 環境介紹
```bash
Ruby version 2.6.3
Rails version 5.2.3
Git version 2.23.0
```
[教學範例 GitHub](https://github.com/River-Ye/travis_ci_test)
# Travis CI
[Travis CI](https://travis-ci.org) 是在軟體開發領域中的一個在線的，分布式的持續集成服務，用來構建及測試在 GitHub 託管的代碼。  
它提供了多種程式語言的支持，包括 Ruby、JavaScript、Java、Scala、PHP、Haskell 和 Erlang 在內的多種語言。許多知名的開源項目使用它來在每次提交的時候進行構建測試，比如 Ruby on Rails，Ruby 和 Node.js。(出處：[維基百科](https://zh.wikipedia.org/wiki/Travis_CI))  

# 開始前
你要有：
1. Ruby、Rails、Git、Postgresql 等的基本環境([沒有可參考這篇建置](https://riverye.com/2019/10/12/Windows%2010%20%E5%AE%89%E8%A3%9D%20Ruby%20+%20Rails%20+%20Node.js%20+%20Git%20+%20postgresql/))
2. [GitHub](https://github.com) 及 [Travis CI](https://travis-ci.org) 的帳號密碼 (免費註冊)

# 如何設定 Ruby on Rails 專案
### 1. 裝 [rspec-rails gem](https://rubygems.org/gems/rspec-rails)
```ruby
# Gemfile

group :development, :test do
  ...
  
  gem 'rspec-rails', '~> 3.9'
end
```
換好資料庫後，終端機輸入
```bash
$ bundle
$ rails g rspec:install
```

### 2. 將原本 sqlite 換成 [pg gem](https://rubygems.org/gems/pg)
```ruby
# Gemfile

gem 'pg', '~> 1.1', '>= 1.1.4'
```
```ruby
# config/database.yml

default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  database: travis_ci_test_development

test:
  <<: *default
  database: travis_ci_test_test

production:
  <<: *default
  database: travis_ci_test_production

# database 名稱自取
```
換完資料庫後，記得要
```bask
$ bundle
$ rails db:migrate:reset
```

### 3. 以 Rails scaffold 測試為例 (可忽略)
```
$ rails g scaffold User name role:integer email gender:integer tel
$ rails db:migrate
$ rspec
```

顯示如下

![](https://i.imgur.com/Erf8NC3.png)

### 4. 在專案目錄底下新增「.travis.yml」
```yaml
# .travis.yml

language: ruby
rvm:
- 2.6.3
install: bundle install
services:
  - postgresql
script:
  - bundle exec rake db:migrate:reset RAILS_ENV=test
  - bundle exec rspec
 
# 可依需求調整
```
### 5. 建立 GitHub 專案 (或在現有的專案 push 上去也可以)
**要先有 GitHub 專案，Travis CI 同步時才能找到喔。**

### 6. 設定 Travis CI 與 GitHub 同步專案
Travis CI 登入後，右上角 [Settings](https://travis-ci.org/account/repositories) 即可設定。

![](https://i.imgur.com/XIbBSOf.png)

### 7. 回 Travis CI 首頁，點左側邊專案名稱

![](https://i.imgur.com/ZGM49x7.png)

### 8. 將帶有「.travis.yml」的 commit push 至 GitHub

![](https://i.imgur.com/joWXDI1.png)

### 9. push 至 GitHub 後，在 Travis CI 會看見正在執行的畫面
需要跑一些時間(幾分鐘不等)，基本上有在執行，代表有順利載入 Travis CI

![](https://i.imgur.com/hpHdPhK.jpg)

### 10. 回 GitHub 點 commits 能看見已執行通過(有綠色V)

![](https://i.imgur.com/myAhzQU.png)

### 11. 將 test_ci branch push 至 GitHub 發 pr

![](https://i.imgur.com/9XEwOUw.png)

# 小結
設定過一次再回想時，會發現比想像中簡單，精簡流程如下：
1. 設定「.travis.yml」檔
1. push Github
2. 設定 Travis CI

簡單來說是這樣，上述不清楚部分，能參考[教學範例 GitHub](https://github.com/River-Ye/travis_ci_test)。

---

本文同步於 [小菜的 Blog](https://riverye.com) [https://riverye.com](https://riverye.com)