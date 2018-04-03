class DataController < ApplicationController
  #protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  def five
    rv = {
      english: "five",
      spanish: "cinco",
      french: "cinq"
    }
    respond_to do |format|
      format.json { render json: rv }
    end
  end

  def twelve
    rv = {
      english: "twelve",
      spanish: "doce"
    }
    respond_to do |format|
      format.json { render json: rv }
    end
  end

  def eggcho
    rv = {}
    params.each do |k,v|
      next unless rv[k].is_a? String
      rv[k] = "egg" + v
    end
    respond_to do |format|
      format.json { render json: rv }
    end
  end
end
