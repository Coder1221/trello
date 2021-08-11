class RenameTableNames < ActiveRecord::Migration[6.1]

  def up
      rename_table :tasks , :lists
      rename_table :subtasks ,:todos
      rename_column :todos, :task_id, :list_id
  end

  def down
    rename_column :todos, :list_id, :task_id
    rename_table :todos, :subtasks
    rename_table :lists, :tasks
  end
end
