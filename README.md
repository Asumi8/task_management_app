# User
users テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  user_name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

# Task
tasks テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  user_id  |    |
|  title  |  string  |
|  content  |  text  |
|  expired_at  |  date  |
|  priority  |  string  |

# Label
labels テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  label_name  |  string  |

# 　LabelManagement
label_managements テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  task_id  |    |
|  label_id  |    |


# herokuへのデプロイ方法
1. config/route.rbでrootを設定
2. herokuへログイン(以下ターミナル)
   $heroku login
3. herokuに新しいアプリケーションを作成
   $heroku create
4. herokuが紐づいているか確認
   $git remote -v
5. 以下、いつも同じエラーが出るのでエラー回避
   $heroku stack:set heroku-20
   $heroku stack
   $bundle lock --add-platform x86_64-linux
6. gitへコミット
   $git add .
   $git commit -m ""
7. herokuへのデプロイ
   $git push heroku step2:master
8. DBのマイグレート
   $heroku run rails db:migrate
