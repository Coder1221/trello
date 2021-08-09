class CreateSubtasks < ActiveRecord::Migration[6.1]
  def change
    create_table :subtasks do |t|
      t.integer :task_id
      t.string :title
      t.string :description
    end
  end
end
