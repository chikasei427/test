module SessionsHelper

  def current_photographer
    @current_photographer ||= Photographer.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_photographer
  end

end

