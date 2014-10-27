class PostsController < ApplicationController

  def index
    @posts = Post.published.order(:published_at).reverse_order
  end

  def show
    @post = Post.find_by(nice_url: params[:id])
    render "invalid_post" unless (@post && @post.published?)
  end

  def destroy
    @post = Post.find(params[:id])
    headline = @post.headline
    @post.destroy

    redirect_to posts_url, notice: "Post '#{headline}' was successfully deleted."
  end 

end

