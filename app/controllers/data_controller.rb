class DataController < ApplicationController

  def five
    respond_to do |format|
      rv = {
        english: "five",
        spanish: "cinco",
        french: "cinq"
      }
      format.json { render json: rv }
    end
  end

  def postcount
    respond_to do |format|
      rv = { count: Post.count }
      format.json { render json: rv }
    end
  end

end
