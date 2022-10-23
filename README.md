# users テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  user_name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

# task テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  user_id  |    |
|  task_name  |  string  |
|  content  |  text  |
|  expiry_date  |  integer  |
|  priority  |  string  |

# label テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  label_name  |  string  |

#  label_management テーブル
|  カラム名  |  データ型  |
| ---- | ---- |
|  task_id  |    |
|  label_id  |    |