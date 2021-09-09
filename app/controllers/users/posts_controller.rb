class Users::PostsController < ApplicationController
before_action :ensure_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :company_name, :image, :introduction, :assignment, :target)
  end
  
  def ensure_post
   @post = Post.find(params[:id])
  end

end
