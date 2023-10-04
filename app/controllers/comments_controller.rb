class CommentsController < ApplicationController
  load_and_authorize_resource
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    return unless @comment.save

    redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully added!'
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to user_post_path
    else
      flash.now[:error] = 'Error: Comment could not be deleted'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
