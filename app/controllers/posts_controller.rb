class PostsController < ApplicationController

  def index
    @page_title = "Posts Archive"
    @posts = Post.published.order(:published_at).reverse_order
  end

  def show
    @post = Post.find_by(nice_url: params[:id])
    @prev_post = @post.previous
    @next_post = @post.next

    @page_title = @post.headline
    unless @post && @post.published?
      @page_title = "Invalid Page"
      render "shared/invalid_item"
    end
  end

end

