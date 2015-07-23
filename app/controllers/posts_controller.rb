class PostsController < ApplicationController

  def index
    @page_title = "Posts Archive"
    @posts = Post.published.order(:published_at).reverse_order
  end

  def show
    @post = Post.find_by(nice_url: params[:id])
    @page_title = @post.try(:headline)
    unless @post && @post.published?
      @page_title = "Invalid Page"
      render "invalid_post"
    end
  end

end

