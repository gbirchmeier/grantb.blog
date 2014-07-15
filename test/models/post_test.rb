require 'test_helper'
 
class PostTest < ActiveSupport::TestCase

  test "published and unpublished scopes" do
    FactoryGirl.create(:post, headline: "aaa", published_at: DateTime.now)
    FactoryGirl.create(:post, headline: "bbb", published_at: nil)

    published = Post.published
    unpublished = Post.unpublished

    assert_equal 1, published.count
    assert_equal 1, unpublished.count
    assert_equal "aaa", published[0].headline
    assert_equal "bbb", unpublished[0].headline
  end

  test "recent" do
    FactoryGirl.create(:post, headline: "aaa", published_at: DateTime.new(2014,01,01))
    FactoryGirl.create(:post, headline: "bbb", published_at: DateTime.new(2014,01,02))
    FactoryGirl.create(:post, headline: "ccc", published_at: DateTime.new(2014,01,03))
    FactoryGirl.create(:post, headline: "ddd", published_at: DateTime.new(2014,01,04))
    FactoryGirl.create(:post, headline: "eee", published_at: nil)

    a = Post.recent(3)
    assert_equal 3, a.length
    assert_equal "ddd",a[0].headline
    assert_equal "ccc",a[1].headline
    assert_equal "bbb",a[2].headline
    assert_nil a.find {|p| p.headline=="eee"}
    
    a = Post.recent(12)
    assert_equal 4, a.length
    assert_equal "aaa",a.last.headline
    assert_nil a.find {|p| p.headline=="eee"}
  end

  test "previous and next" do
    FactoryGirl.create(:post, headline: "000", published_at: DateTime.new(2014,01,01))
    FactoryGirl.create(:post, headline: "aaa", published_at: DateTime.new(2014,01,02))
    FactoryGirl.create(:post, headline: "bbb", published_at: DateTime.new(2014,01,03))
    FactoryGirl.create(:post, headline: "ccc", published_at: DateTime.new(2014,01,04))
    FactoryGirl.create(:post, headline: "111", published_at: DateTime.new(2014,01,05))

    p = Post.find_by(headline:"bbb")
    assert_equal "aaa", p.previous.headline
    assert_equal "ccc", p.next.headline
  end

end

