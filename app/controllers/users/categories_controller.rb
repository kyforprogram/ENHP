class Users::CategoriesController < ApplicationController
before_action :authenticate_user!

  def show
    @parents = Category.where(ancestry: nil)
    @category = Category.find(params[:id])
  end


end
