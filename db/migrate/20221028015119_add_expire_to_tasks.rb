class AddExpireToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :expired_at, :date, null:false, default:"1000-01-01"
  end
end
