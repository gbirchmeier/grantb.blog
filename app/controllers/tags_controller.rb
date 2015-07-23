class TagsController < ApplicationController

  def index
    @page_title = "All Tags"
    @tags = Tag.published.order(:name)
  end

  def show
    @page_title = "Posts tagged &quot;#{params[:id]}&quot;"
    @name = params[:id]
    @tag = Tag.find_by(name: params[:id])
  end

end
