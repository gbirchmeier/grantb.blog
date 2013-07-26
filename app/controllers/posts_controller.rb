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

end
