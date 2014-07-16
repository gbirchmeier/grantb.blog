class AdminPostsController < ApplicationController
  layout "admin"

  before_action :credit_check

  def index
    @published_posts = Post.published.order(:published_at).reverse_order
    @draft_posts = Post.unpublished.order(:updated_at).reverse_order
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post
      @post = nil unless @post.published?
    end
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
      redirect_to admin_post_path(@post), notice: "Post was successfully updated."
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
    params.require(:post).permit(:headline,:content,:markup_type)
  end

  def credit_check
    redirect_to not_allowed_path unless @current_user
  end
end
