class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update]
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

  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "You updated your comment!"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
