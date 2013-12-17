class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote, :destroy]
  before_action :require_user, only: [:index, :show, :new, :create, :edit, :update, :vote]
  before_action :require_creator_or_admin?, only: [:edit, :update]

  def index
    @posts = Post.page(params[:page]).order("created_at DESC").per_page(5)
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

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "You updated the post!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "You successfully deleted your post!"
      redirect_to posts_path
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted!"
        else
          flash[:error] = "Oops, you can only vote on a post once!"
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :url, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator_or_admin?
    access_denied unless logged_in? && (@post.creator == current_user || current_user.admin?)
  end
end
