class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, :through => :post_tags

  validates :name, presence: true
  validates_format_of :name, with: /\A[0-9a-zA-Z\-]+\z/

  TAG_SEPARATOR = " "

  scope :published, -> { joins(:posts).merge(Post.published) }


  def path
    "/tags/#{self.name}"
  end

end
