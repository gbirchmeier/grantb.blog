class Post < ActiveRecord::Base
  belongs_to :user, :inverse_of=>:posts

  scope :published, -> { where("published_at IS NOT NULL") }
  scope :unpublished, -> { where("published_at IS NULL") }

  def published?
    !published_at.nil?
  end


end

