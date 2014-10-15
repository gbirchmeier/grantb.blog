require 'test_helper'

class TagTest < ActiveSupport::TestCase

  test "basic creation" do
    assert FactoryGirl.build(:tag,name:"what").valid?
  end

  test "can't have blank or empty name" do
    refute FactoryGirl.build(:tag,name:nil).valid?
    refute FactoryGirl.build(:tag,name:"").valid?
    refute FactoryGirl.build(:tag,name:" ").valid?
  end

end
