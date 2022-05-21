class HomesController < ApplicationController

  def top
    @posts = Post.recent.includes(:user).first(4)#recentはpost.rbの１８行目
    # @posts = Post.all.recent.limit(4)
    @categories = Category.where(ancestry: nil)
    # @categories = Category.all
  end

  def guest_sign_in
    random_guestname = SecureRandom.alphanumeric(10)
    # @random_guestemail = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
    random_guestemail = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'@'].sample(1).join + [*'0'..'9'].sample(1).join
    puts random_guestemail
    # @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    # user = User.find_or_create_by!(name: 'ゲストユーザー', email: 'guest@example.com') do |user|
    # user = User.find_or_create_by!(name: @random_guestname, email: 'guest@example.com') do |user|
    user = User.find_or_create_by!(name: random_guestname, email: random_guestemail) do |user|
      user.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
      # user.password = '123456'
      user.company = "DMM WEBCAMP"
      user.introduction = "DMMの卒業生です。SEを目指して日々修行してます"
    end
    sign_in user
    redirect_to user_path(current_user), notice: "ゲストユーザーとしてログイン"
  end
end
