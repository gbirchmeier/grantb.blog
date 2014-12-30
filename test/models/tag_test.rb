require 'test_helper'

class TagTest < ActiveSupport::TestCase

  test "allowed names (non-empty, only alpha-num and dash allowed)" do
    assert FactoryGirl.build(:tag,name:"what").valid?
    assert FactoryGirl.build(:tag,name:"a-b").valid?
  end

  test "unallowed names" do
    refute FactoryGirl.build(:tag,name:nil).valid?
    refute FactoryGirl.build(:tag,name:"").valid?
    refute FactoryGirl.build(:tag,name:" ").valid?
    refute FactoryGirl.build(:tag,name:"a b").valid?
    refute FactoryGirl.build(:tag,name:"a_b").valid?
    refute FactoryGirl.build(:tag,name:"a?b").valid?
  end

  test "scope published" do
    p1 = FactoryGirl.create(:post, headline: "aaa", published_at: DateTime.new(2014,01,04))
    p1.tags << Tag.new(name:"publishedtag")
    p2 = FactoryGirl.create(:post, headline: "bbb", published_at: nil)
    p2.tags << Tag.new(name:"othertag")
    published_tags = Tag.published
    assert_equal 1, published_tags.count
    assert_equal "publishedtag", published_tags.first.name
  end

end
