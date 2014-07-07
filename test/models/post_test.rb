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

  test "recent" do
    u = User.create!(username:"x",email:"x",password:"x",password_confirmation:"x")
    Post.new(headline:"aaa",content:"z",user:u,published_at:DateTime.new(2014,01,01)).save!
    Post.new(headline:"bbb",content:"z",user:u,published_at:DateTime.new(2014,01,02)).save!
    Post.new(headline:"ccc",content:"z",user:u,published_at:DateTime.new(2014,01,03)).save!
    Post.new(headline:"ddd",content:"z",user:u,published_at:DateTime.new(2014,01,04)).save!
    Post.new(headline:"eee",content:"z",user:u).save!

    a = Post.recent(3)
    assert_equal 3, a.length
    assert_equal "ddd",a[0].headline
    assert_equal "ccc",a[1].headline
    assert_equal "bbb",a[2].headline
    assert_nil a.index {|p| p.headline=="eee"}
    
    a = Post.recent(12)
    assert_equal 4, a.length
    assert_equal "aaa",a.last.headline
    assert_nil a.index {|p| p.headline=="eee"}
  end

end

