class Users::LikesController < ApplicationController

  def create
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    redirect_to request.referer || post_path(params[:post_id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
    redirect_to request.referer || post_path(params[:post_id])
  end


end
