class TagsController < ApplicationController

  def index
    @page_title = "All Tags"
    @tags = Tag.published_counts_by_name
  end

  def show
    @page_title = "Posts tagged &quot;#{params[:id]}&quot;"
    @name = params[:id]
    @tag = Tag.find_by(name: params[:id])
  end

end
