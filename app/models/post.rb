class Post < ActiveRecord::Base
  belongs_to :user, :inverse_of=>:posts
#  attr_accessible :username,:email
#  attr_accessible :password, :password_confirmation

  default_scope { order(:id) }

  scope :published, -> { where("published_at IS NOT NULL") }
  scope :unpublished, -> { where("published_at IS NULL") }
end

