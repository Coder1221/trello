require "test_helper"

class SubtasksControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get subtasks_destroy_url
    assert_response :success
  end
end
