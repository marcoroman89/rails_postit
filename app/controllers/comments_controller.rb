class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was created!"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    flash[:notice] = "Your vote was counted!"
    redirect_to posts_path
  end
end
