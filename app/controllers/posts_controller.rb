class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit!)

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

  end
end
