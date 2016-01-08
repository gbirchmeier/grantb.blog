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

  test "validates/strips nice_url" do
    #valid
    assert_equal "123-Pants_", FactoryGirl.create(:post,nice_url:" 123-Pants_ ").nice_url

    #not valid
    refute FactoryGirl.build(:post,nice_url:"no&specialchars").valid?
  end

  test "basic tagging" do
    FactoryGirl.create(:post, headline: "aaa")
    assert Post.first.tags.empty?

    assert_equal 0, Tag.count
    Post.first.tags << Tag.new(name:"bing")
    Post.first.tags << Tag.new(name:"bong")
    assert_equal "bing bong", Post.first.tags_as_string
    assert_equal 2, Tag.count
    assert_equal 2, PostTag.count
  end

  test "assign_tags_from_string" do
    p = FactoryGirl.create(:post, headline: "aaa")
    p.assign_tags_from_string("red gold")
    assert_equal 2, Tag.count
    assert_equal "gold red", Post.find_by(headline:"aaa").tags_as_string

    p.assign_tags_from_string("red yellow")
    assert_equal 3, Tag.count # "gold" still there, even though not used
    assert_equal "red yellow", Post.find_by(headline:"aaa").tags_as_string

    p.assign_tags_from_string("green")
    assert_equal "green", Post.find_by(headline:"aaa").tags_as_string
    assert_equal 4, Tag.count

    p.assign_tags_from_string("") #nil also works
    assert_equal "", Post.find_by(headline:"aaa").tags_as_string
    assert_equal 4, Tag.count
  end

end

