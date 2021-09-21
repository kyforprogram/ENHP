class Admins::UsersController < ApplicationController
before_action :authenticate_admin!
before_action :find_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to admins_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_image, :introduction, :job_category, :is_deleted)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
