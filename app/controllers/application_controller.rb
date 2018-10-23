class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def authenticate_user
    session[:return_to] ||= request.referer
    if session[:user_id] then
      @user = User.find(session[:user_id])
      if @user.nil? then
        redirect_to login_path
      end
    else
      redirect_to login_path
    end
  end
end
