class FrontPageController < ApplicationController

  def index
    @posts = Post.published.order("published_at DESC").reverse_order.limit(6)
    @prev_post = @posts.pop if @posts.count > 5
  end

end
