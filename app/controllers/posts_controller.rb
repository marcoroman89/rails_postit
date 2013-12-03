class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.page(params[:page]).order("created_at DESC").per_page(10)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user


    if @post.save
      flash[:notice] = "You created a new post!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "You Updated the Post!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    flash[:notice] = "Your vote was counted!"
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :url)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_creator
    access_denied if @post.creator != current_user
  end
end
