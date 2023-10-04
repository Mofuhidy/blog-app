class PostsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :post, through: :user
  
  before_action :set_user, only: [:index, :show]
  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully!'
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to user_posts_path, notice: 'Post was successfully deleted!'
    else
      flash.now[:error] = 'Error: Post could not be deleted'
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
