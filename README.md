# users テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  user_name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

# tasks テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  user_id  |    |
|  title  |  string  |
|  content  |  text  |
|  expiry_date  |  integer  |
|  priority  |  string  |

# labels テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  label_name  |  string  |

#  label_managements テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  task_id  |    |
|  label_id  |    |