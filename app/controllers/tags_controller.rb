class TagsController < ApplicationController

  def index
    @tags = Tag.published.order(:name)
  end

  def show
    @name = params[:id]
    @tag = Tag.find_by(name: params[:id])
  end

end
