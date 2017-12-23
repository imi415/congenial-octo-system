class AuthController < ApplicationController

  def login
  end

  def authenticate
    @user = User.find_by(:username => params[:username]).authenticate(params[:password])
    if @user then
      session[:user_id] = @user.id
    else
      @msg = "Not match!"
    end
  end

  def logout
  end
end
