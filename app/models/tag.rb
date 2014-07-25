class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, :through => :post_tags

  TAG_SEPARATOR = " "

  def pretty_path
    "/tags/#{self.name}"
  end
end
