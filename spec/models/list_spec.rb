require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { List.new }
  let(:board) { Board.new }
  describe "#initialize" do
    it "List witout board does not exists" do
      expect(subject.save).to eq(false)
    end
  end
end
