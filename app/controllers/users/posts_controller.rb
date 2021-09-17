class Users::PostsController < ApplicationController
before_action :authenticate_user!, only: %i[new create show edit update destroy]
before_action :find_post, only: %i[show edit update destroy]

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
    @post_comment = PostComment.new
    unless ViewCount.find_by(user_id: current_user.id, post_id: @post.id)
    view_counts = ViewCount.new
    view_counts.user_id = current_user.id
    view_counts.post_id = @post.id
    view_counts.save
    end
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

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :company_name, :image, :introduction, :assignment, :target)
  end

  def find_post
   @post = Post.find(params[:id])
  end

end
