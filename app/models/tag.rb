class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, :through => :post_tags

  validates :name, presence: true
  validates_format_of :name, with: /\A[0-9a-zA-Z\-]+\z/

  TAG_SEPARATOR = " "

  def self.published_counts_by_name
    # thanks to http://www.sitepoint.com/tagging-scratch-rails/
    Tag.select("tags.id, tags.name, count(post_tags.tag_id) as count").
      joins(:post_tags).
      group("post_tags.tag_id").
      order('tags.name')
  end

  def path
    "/tags/#{self.name}"
  end

end
