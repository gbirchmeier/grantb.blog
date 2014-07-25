class TagsController < ApplicationController

  def index
    @tags = Tag.all.order(:name)
  end

  def show
    id = params[:id]
    @name = params[:id]
    @tag = Tag.find_by(name: params[:id])
  end

end
