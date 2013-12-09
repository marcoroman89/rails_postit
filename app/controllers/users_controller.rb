class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

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

  def show; end

  def edit; end

  def update
    @user =User.find(params[:id])
    if @user.update(users_params)
      flash[:notice] = "Thanks, your info has been updated!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def users_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "Oops, you can't do that."
      redirect_to root_path
    end
  end
end
