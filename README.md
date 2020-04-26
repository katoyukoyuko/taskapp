# README

## DBテーブル情報

### tasks

 - id : integer
 - name : string
 - description : string 
 - status : integer
 - priority : integre
 - user_id : integer
 - label_id : integer


 ### users

 - id : integer
 - name : string
 - password : string
 - password_digest : string


 ### labelings

 - id : integer
 - task_id : integer
 - label_id : integer

 ### labels

 - id : integer
 - name : string


## アプリ情報
- Ruby 2.6.5
- Rails 5.2.3
- psql 12.1


## デプロイ方法

### 初回
1. heroku create で新規appを作成する
2. git add -A
3. git commit -m "init"
4. git push heroku master
5. heroku run rails db:create
6. heroku run rails db:migrate

### 2回目以降
1. github に push すると heroku にもデプロイされる
2. アセットコンパイルは再度しないといけない
   rails assets:precompile RAILS_ENV=production

