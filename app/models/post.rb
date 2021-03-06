require 'redcarpet_renderers'

class Post < ActiveRecord::Base
  belongs_to :user, :inverse_of=>:posts
  has_many :post_tags
  has_many :tags, :through => :post_tags

  normalize_attributes :nice_url

  scope :published, -> { where("published_at IS NOT NULL") }
  scope :unpublished, -> { where("published_at IS NULL") }

  validates :headline, :content, :user, :nice_url, presence: true
  validates_format_of :nice_url, with: /\A\s*[0-9a-zA-Z\-_]+\s*\z/, allow_blank: true

  module MarkupType
    MARKDOWN = 'markdown'
    HTML = 'html'
  end
  MARKUP_TYPES = ["markdown","html"]
  validates :markup_type, inclusion: { in: MARKUP_TYPES }

  def published?
    !published_at.nil?
  end

  def previous
    Post.published.where("published_at < ?", self.published_at).order("published_at DESC").limit(1).first
  end

  def next
    Post.published.where("published_at > ?", self.published_at).order("published_at ASC").limit(1).first
  end

  def self.before(n,datetime)
    # is exclusive
    Post.published.where("published_at < ?", datetime).order("published_at DESC").limit(n).to_a
  end

  def self.after(n,datetime)
    # is exclusive
    Post.published.where("published_at > ?", datetime).order("published_at ASC").limit(n).reverse
  end

  def pretty_path
    "/posts/#{self.nice_url || self.id}"
  end

  def get_renderer
    @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :fenced_code_blocks=>true,
      :strikethrough => true,
      :superscript => true,
      :underline => true,
      :highlight => true,
    )
  end

  def get_blockless_renderer
    @blockless_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTMLWithoutBlockElements,
      :strikethrough => true,
      :superscript => true,
      :underline => true,
      :highlight => true,
    )
  end

  def content_as_html
    case self.markup_type
    when Post::MarkupType::HTML
      self.content
    when Post::MarkupType::MARKDOWN
      get_renderer.render(self.content)
    else
      "Can't render content.  Unknown markup type '#{self.markup_type}'"
    end
  end

  def headline_as_html
    get_blockless_renderer.render(self.headline)
  end

  def assign_tags_from_string(list)
    a = []
    if list.present?
      list.split(/#{Tag::TAG_SEPARATOR}+/).each {|tagname|
        tag = Tag.find_by(name: tagname) || Tag.new(name: tagname)
        a << tag
      }
    end
    self.tags = a
  end

  def tags_as_string
    tags.order(:name).collect(&:name).join(Tag::TAG_SEPARATOR)
  end
end

