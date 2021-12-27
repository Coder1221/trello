require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:user)  { User.create!(username: "test user" , email: 'test@exmaple.com' , password: 'password') }
  let(:board) { Board.new }
 
  describe "#Initialize" do
    it "Without user does not exist" do
      expect(board.save).to eq(false)
    end

    it "Name should not be equal to nil even user exist" do
      board.name = nil
      expect(board.save).to eq(false) 
    end

    it "Does not create without userid" do
      board.name = "testBoard"
      expect(board.save).to eq(false)
    end

    it "board should save on existing user id and name" do
      board.name = 'test board'
      board.user_id = user.id
      expect(board.save!).to eq(true) 
    end
  end
   
end