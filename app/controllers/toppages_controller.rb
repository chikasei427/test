class ToppagesController < ApplicationController
  def index
    if logged_in?
      puts @current_photographer.id
      redirect_to photographer_path(@current_photographer.id)
    end
  end
end
