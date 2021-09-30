class Users::LikesController < ApplicationController
before_action :authenticate_user!
before_action :find_post

  def create
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    #redirect_to request.referer || post_path(params[:post_id])
    @post.create_notification_like!(current_user)
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
    #redirect_to request.referer || post_path(params[:post_id])
  end
  
  
  
  private
  
  
  
  
  # before_action---------------------------------------------------------------------
  def find_post
    @post = Post.find(params[:post_id])
  end
end
