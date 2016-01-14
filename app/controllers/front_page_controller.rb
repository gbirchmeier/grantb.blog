class FrontPageController < ApplicationController
  include DateHelper

  FRONT_PAGE_POSTS_COUNT = 10

  def index
    @page_title = nil
    @posts = Post.published.order("published_at DESC").limit(FRONT_PAGE_POSTS_COUNT+1)
    if @posts.length > FRONT_PAGE_POSTS_COUNT
      @posts.pop
      @older_time = @posts.last.published_at.to_i
    end
  end

  def before
    d = Time.at(params[:timeint].to_i).utc.to_datetime
    @page_title = "Posts before #{numeric_date_and_time(d)}"
    @posts = Post.before(FRONT_PAGE_POSTS_COUNT+1,d)
    @newer_time = @posts.first.published_at.to_i
    if @posts.length > FRONT_PAGE_POSTS_COUNT
      @posts.pop
      @older_time = @posts.last.published_at.to_i
    end
    render 'before_after'
  end

  def after
    d = Time.at(params[:timeint].to_i).utc.to_datetime
    @page_title = "Posts after #{numeric_date_and_time(d)}"
    @posts = Post.after(FRONT_PAGE_POSTS_COUNT+1,d)
    if @posts.length <= FRONT_PAGE_POSTS_COUNT
      redirect_to root_url
      return
    end
    @posts.shift
    @newer_time = @posts.first.published_at.to_i
    @older_time = @posts.last.published_at.to_i
    render 'before_after'
  end



end
