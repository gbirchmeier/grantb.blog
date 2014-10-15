class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, :through => :post_tags

  validates_format_of :nice_url, with: /\A\s*[0-9a-zA-Z\-_]+\s*\z/, allow_blank: true

  TAG_SEPARATOR = " "

  def path
    "/tags/#{self.name}"
  end

end
