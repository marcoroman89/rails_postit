class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you're logged in!"
      redirect_to posts_path
    else
      flash[:error] = "Oops, something is wrong with your username or password!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You logged out successfully, see you soon!"
    redirect_to root_path
  end
end
