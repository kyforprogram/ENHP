class Users::LikesController < ApplicationController
before_action :authenticate_user!
before_action :ensure_post

  def create
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    #redirect_to request.referer || post_path(params[:post_id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
    #redirect_to request.referer || post_path(params[:post_id])
  end

  private

  def ensure_post
    @post = Post.find(params[:post_id])
  end
end
