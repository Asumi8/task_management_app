class ChangeColumnNullTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :content, :text, null: false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
