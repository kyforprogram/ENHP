class Users::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    following = current_user.relationships.build(follower_id: params[:user_id]) #パラメーターからuser_idを取得
    following.save
    redirect_to request.referrer
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])#パラメーターからuser_idを取得
    following.destroy
    redirect_to request.referrer
  end
end
