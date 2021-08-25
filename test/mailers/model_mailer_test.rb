require "test_helper"

class ModelMailerTest < ActionMailer::TestCase
  test "new_user_invitation" do
    mail = ModelMailer.new_user_invitation
    assert_equal "New user invitation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
