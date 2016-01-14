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

end
