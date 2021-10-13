require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) { Todo.new }
  it "does not save with out list_id" do
    # puts subject
    # puts todo
    expect(todo.save).to eq(false)
    # todo.list_id = 1
    # r
    # expect(todo.save).to eq(true)
  end
end
