class Users::CategoriesController < ApplicationController
before_action :authenticate_user!

  def show
    @category = Category.find(params[:id])
    @parents = Category.where(ancestry: nil)
    @posts = @category.set_posts
    @posts = @posts.includes(:user).recent.page(params[:page]).per(6)#recentはpost.rbの１８行目

  end

end
