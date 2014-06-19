class Post < ActiveRecord::Base
  belongs_to :user, :inverse_of=>:posts

  scope :published, -> { where("published_at IS NOT NULL") }
  scope :unpublished, -> { where("published_at IS NULL") }

  module MarkupType
    MARKDOWN = 'markdown'
    HTML = 'html'
  end
  MARKUP_TYPES = ["markdown","html"]
  validates :markup_type, inclusion: { in: MARKUP_TYPES }

  def published?
    !published_at.nil?
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

end

