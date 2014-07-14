class PostsController < ApplicationController

  def index
    @posts = Post.published.order(:published_at).reverse_order
  end

  def show
    @post = Post.find_by(id: params[:id])
    render "invalid_post" unless (@post && @post.published?)
  end

end

