require "test_helper"

class PostTest < ActiveSupport::TestCase
def setup
    User.create!(username: "one", email: "two@one.com", password:"three")
    @post= Post.new(user_id: User.first.id, title: "hello", body: "world")
  end
  test "should be valid" do
    assert @post.valid?
  end
  test "title should be present" do
    @post.title = "     "
    assert_not @post.valid?
  end
  test "body should be present" do
    @post.body = "     "
    assert_not @post.valid?
  end
  test "title should not be longer than 500 characters" do
    @post.title = "a" * 501
    assert_not @post.valid?
  end
  test "body should not be longer than 3500 characters" do
    @post.body = "a" * 3501
    assert_not @post.valid?
  end
end
