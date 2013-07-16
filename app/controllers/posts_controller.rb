class PostsController < ApplicationController

  def index
    @my_user = current_user
  end

end
