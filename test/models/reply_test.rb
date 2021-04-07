require "test_helper"

class ReplyTest < ActiveSupport::TestCase
  def setup
    User.create!(username: "one", email: "two@one.com", password:"three")
    Post.create!(user_id: User.first.id, title: "hello", body: "world")
    @reply= Reply.new(user_id: User.first.id, post_id: Post.first.id, body: "hiii")
  end
  test "should be valid" do
    assert @reply.valid?
  end
  test "body should be present" do
    @reply.body = ""
    assert_not @reply.valid?
  end
end
