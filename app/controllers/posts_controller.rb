class PostsController < ApplicationController

  def index
    @posts = Post.published.order(:published_at).reverse_order
  end

  def drafts
    unless @current_user
      redirect_to not_allowed_path and return
    end
    
    @posts = Post.unpublished.order(:updated_at).reverse_order
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
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

