class Admin::PostsController < Admin::AdminController

  before_filter :set_controller_crumb, only: [:index,:new,:edit,:show,:delete]

  def index
    @action_crumb = "Index"
    @published_posts = Post.published.order(:published_at).reverse_order
    @draft_posts = Post.unpublished.order(:updated_at).reverse_order
  end

  def show
    @action_crumb = "Post Details"
    @post = Post.find_by(id: params[:id])
  end

  def new 
    @action_crumb = "New Post"
    @post = Post.new
  end 

  def edit
    @action_crumb = "Edit Post"
    @post = Post.find(params[:id])
  end 

  def delete
    @action_crumb = "Delete Post"
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.published_at = DateTime.now if params[:is_published]
    @post.user = @current_user
    if @post.save
      @post.assign_tags_from_string(params[:post][:tags])
      redirect_to admin_post_path(@post), notice: "Post was successfully created."
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
      @post.assign_tags_from_string(params[:post][:tags])
      redirect_to admin_post_path(@post), notice: "Post was successfully updated."
    else
      render :action=>"edit"
    end 
  end

  def destroy
    @post = Post.find(params[:id])
    dead = @post.headline
    @post.destroy
    redirect_to admin_posts_path, notice: "Successfully deleted post with headline '#{dead}'."
  end

private
  def post_params
    params.require(:post).permit(:headline,:content,:markup_type,:nice_url)
  end

  def set_controller_crumb
    @controller_crumb = {label: "Posts", path: admin_posts_path}
  end

end
