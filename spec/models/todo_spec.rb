require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:user)  { User.create!(username: "test user" , email: 'test@exmaple.com' , password: 'password') }
  let(:board) { Board.create!(name: "test board", user_id: user.id) }
  let(:list)  { List.create!(name: "test list" , user_id: user.id , board_id: board.id ) }
  let(:todo)  { Todo.new }

  describe "Initialization" do
    it "does not save with out list_id" do
      expect(todo.save).to eq(false)
    end

    it "should save with user id" do
      todo.list_id = list.id
      expect(todo.save).to eq(true)
    end
  end
end
