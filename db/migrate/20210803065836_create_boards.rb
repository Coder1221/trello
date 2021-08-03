class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :user_id
      t.string :name ,null: false, default: ""
      t.timestamps
    end
    add_index :boards, :name
  end
end
