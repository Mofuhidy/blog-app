class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.create(user: current_user, post: @post)

    if @like.persisted?
      flash[:notice] = 'You liked this post!'
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      flash[:alert] = 'Something went wrong!'
      render :new
    end
    
  end
end
