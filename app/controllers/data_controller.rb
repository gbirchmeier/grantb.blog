class DataController < ApplicationController
  #protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

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

  def twelve
    respond_to do |format|
      rv = {
        english: "twelve",
        spanish: "doce"
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
