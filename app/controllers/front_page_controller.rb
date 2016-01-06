class FrontPageController < ApplicationController

  FRONT_PAGE_POSTS_COUNT = 10

  def index
    @page_title = nil
    @posts = Post.published.order("published_at DESC").limit(FRONT_PAGE_POSTS_COUNT)
  end

end
