class FrontPageController < ApplicationController

  FRONT_PAGE_POSTS_COUNT = 1

  def index
    @posts = Post.published.order("published_at DESC").limit(FRONT_PAGE_POSTS_COUNT+1)
    @prev_post = @posts.pop if @posts.count > 1
  end

end
