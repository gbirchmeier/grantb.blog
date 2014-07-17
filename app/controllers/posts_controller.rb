class PostsController < ApplicationController

  def index
    @posts = Post.published.order(:published_at).reverse_order
  end

  def show
    id = params[:id]
    if(id.match(/^\d+$/))
      @post = Post.find_by(id: params[:id])
    else
      @post = Post.find_by(nice_url: params[:id])
    end
    render "invalid_post" unless (@post && @post.published?)
  end

end

