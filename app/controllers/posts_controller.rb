class PostsController < ApplicationController
  include ApplicationHelper

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

    @opengraph = {}
    @opengraph["og:title"] = @post.headline
    @opengraph["og:type"] = "article"
    @opengraph["og:url"] = current_correct_url()
    @opengraph["og:image"] = "og-logo.png"
    @opengraph["og:site_name"] = "GrantB.net"

    #do the rest after I can use FB's checker

    #@opengraph["og:article:author"] = "#{@post.user.full_name}"
  end

end

