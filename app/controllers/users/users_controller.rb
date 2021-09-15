class Users::UsersController < ApplicationController
before_action :authenticate_user!
before_action :find_user,  except: :index

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
  params.require(:user).permit(:name, :profile_image, :introduction, :job_category)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
