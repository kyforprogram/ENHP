class Users::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def create
    following = current_user.relationships.build(follower_id: params[:user_id]) #パラメーターからuser_idを取得
    following.save
    @user.create_notification_follow!(current_user)
    #redirect_to request.referrer
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])#パラメーターからuser_idを取得
    following.destroy
    #redirect_to request.referrer
  end


  def find_user
    @user = User.find(params[:user_id])
  end

  private
end
