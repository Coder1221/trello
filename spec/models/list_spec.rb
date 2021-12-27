require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user)  { User.create!(username: "test user" , email: 'test@exmaple.com' , password: 'password') }
  let(:board) { Board.create!(name: "test board", user_id: user.id) }
  let(:list)  { List.new }
  
  describe "#initialize" do
    it "with out borad id should not save" do
      expect(list.save).to eq(false)
    end

    it "when board exits it should save" do
      list.board_id = board.id
      list.name = 'Test_board_list'
      expect(list.save).to eq(true)
    end

  end
end
