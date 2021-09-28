class Users::UsersController < ApplicationController
before_action :authenticate_user!
before_action :find_user, only: %i[show edit update followings followers]

  def show
    @posts = @user.posts.all
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(6)
  end

  def index
    @users = User.recent.page(params[:page]).per(12)#recentはuser.rb、２９行目
  end

  def edit
    unless @user == current_user
      redirect_to root_path, alert: "unexpect error"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "successfully."
    else
      render :edit
    end
  end

  #フォロー-------------------------------------------------------------------------
  def followings
    @users = @user.followings.active
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(8)
  end

  def followers
    @users = @user.followers.active
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(8)
  end

  # before_action-------------------------------------------------------------------
  def find_user
    @user = User.active.find(params[:id])
  end

  # private-------------------------------------------------------------------------
  private
  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction, :company)
  end

end
