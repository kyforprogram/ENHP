class Users::UsersController < ApplicationController
before_action :authenticate_user!
before_action :set_user, only: %i[show edit update followings followers]#可読性を上げるため

  def show
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
