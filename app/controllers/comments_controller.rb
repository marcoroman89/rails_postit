class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update]
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was created!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment.post = @post
    if @comment.update(comment_params)
      flash[:notice] = "You updated your comment!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    comment = Comment.find(params[:id])
    Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
    flash[:notice] = "Your vote was counted!"
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
