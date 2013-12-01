class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = "You have registered, now log in."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])
    if @user.update(users_params)
      flash[:notice] = "Thanks, you info has been updated!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
  def users_params
    params.require(:user).permit(:username, :password)
  end
end
