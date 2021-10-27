class HomesController < ApplicationController

  def top
    @posts = Post.recent.includes(:user).first(4)#recentはpost.rbの１８行目
    # @posts = Post.all.recent.limit(4)
    # @root_categories = Category.where(ancestry: nil)
    @categories = Category.all
  end

  def guest_sign_in
    user = User.find_or_create_by!(name: 'ゲストユーザー', email: 'guest@example.com') do |user|
      user.password = '123456'
      user.company = "DMM WEBCAMP"
      user.introduction = "DMMの卒業生です。SEを目指して日々修行してます"
    end
    sign_in user
    redirect_to user_path(current_user), notice: "ゲストユーザーとしてログイン"
  end
end
