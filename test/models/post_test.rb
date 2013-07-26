require 'test_helper'
 
class PostTest < ActiveSupport::TestCase

  test "published and unpublished scopes" do

    u = User.new(username:"x",email:"x",password:"x",password_confirmation:"x")
    u.save!
    Post.new(headline:"aaa",content:"z",user:u,published_at:DateTime.now).save!
    Post.new(headline:"bbb",content:"z",user:u).save!

    published = Post.published
    unpublished = Post.unpublished

    assert_equal 1, published.count
    assert_equal 1, unpublished.count
    assert_equal "aaa", published[0].headline
    assert_equal "bbb", unpublished[0].headline
  end

end

