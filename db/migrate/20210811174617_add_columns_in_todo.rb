class AddColumnsInTodo < ActiveRecord::Migration[6.1]
  def change
    add_column :todos , :status  ,  :integer , default: 0
    add_column :todos , :due_date ,  :datetime
  end
end