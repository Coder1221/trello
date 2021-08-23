class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.string :board_name
      t.string :list_name
      t.string :task
      t.string :status
      t.datetime :due_date
    end
  end
end