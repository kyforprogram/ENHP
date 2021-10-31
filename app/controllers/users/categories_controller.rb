class Users::CategoriesController < ApplicationController
before_action :authenticate_user!

  def show
    @category = Category.find(params[:id])
    @parents = Category.where(ancestry: nil)
    @posts = @category.set_posts.in
  end

end
