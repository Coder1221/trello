class CreateReminders < ActiveRecord::Migration[6.1]
  def change
    create_table :reminders do |t|
      t.string :board_name
      t.string :list_name
      t.string :task
      t.string :status
    end
  end
end