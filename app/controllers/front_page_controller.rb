class FrontPageController < ApplicationController

  def index
    @posts = Post.published.order(:published_at).reverse_order.limit(5)
  end

end
