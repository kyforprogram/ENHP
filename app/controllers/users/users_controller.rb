class Users::UsersController < ApplicationController
before_action :authenticate_user!
before_action :set_user, only: %i[show edit update followings followers]

  def show
    @posts = @user.posts.all
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
  end

  def index
    @users = User.where.not(id: current_user.id).page(params[:page]).per(12)
  end

  def edit
    unless @user == current_user
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def followings
    @users = @user.followings
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(8)
  end

  def followers
    @users = @user.followers
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(8)
  end

  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction, :company)
  end

end
