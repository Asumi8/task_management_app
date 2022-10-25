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
|  expiry_date  |  integer  |
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