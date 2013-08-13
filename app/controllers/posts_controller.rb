class PostsController < ApplicationController

  def index
    @posts = Post.published.order(:published_at).reverse_order
  end

  def admin
    redirect_if_not_logged_in and return
    @published_posts = Post.published.order(:published_at).reverse_order
    @draft_posts = Post.unpublished.order(:updated_at).reverse_order
  end

  def show
    @post = Post.find(params[:id])
    (redirect_if_not_logged_in and return) unless @post.published?
  end

  def new
    redirect_if_not_logged_in and return
    @post = Post.new
  end

  def edit
    redirect_if_not_logged_in and return
    @post = Post.find(params[:id])
  end

  def create
    redirect_if_not_logged_in and return
    @post = Post.new(post_params)
    @post.published_at = DateTime.now if params[:is_published]
    @post.user = @current_user
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :action=>"new"
    end
  end

  def update
    redirect_if_not_logged_in and return
    @post = Post.find(params[:id])
    if @post.published_at
      @post.published_at = nil unless params[:is_published]
    else
      @post.published_at = DateTime.now if params[:is_published]
    end

    if @post.update_attributes(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :action=>"edit"
    end
  end

  def destroy
    redirect_if_not_logged_in and return
    @post = Post.find(params[:id])
    dead = @post.headline
    @post.destroy
    redirect_to posts_path, notice: "Successfully deleted post with headline '<em>#{dead}</em>'."
  end

private
  def post_params
    params.require(:post).permit(:headline,:content)
  end

end

