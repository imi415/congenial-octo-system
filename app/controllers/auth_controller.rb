class AuthController < ApplicationController

  def login
  end

  def authenticate
    @user = User.find_by(:username => params[:username])
    if @user then
      if @user.authenticate(params[:password]) then
        session[:user_id] = @user.id
        redirect_to session.delete(:return_to)
      else
        @msg = "Not match"
      end
    else
      @msg = "Not match!"
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to '/'
  end
end
