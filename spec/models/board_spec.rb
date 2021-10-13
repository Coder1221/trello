require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { Board.new }
 
  describe "#Initialize" do
    it "Without user does not exist" do
      expect(subject.save).to eq(false)
    end

    it "Name should not be equal to nil even user exist" do
      subject.name = nil
      subject.user_id = 1 
      expect(subject.save).to eq(false) 
    end
  end
   
end