class Users::SearchesController < ApplicationController

  def search
    @category = params[:category]
    search = params[:search]
    word = params[:word]
    if @category == "2"
      @posts = Post.includes(:category).search(search, word).page(params[:page]).per(6)
    else
      @user = User.search(search, word).page(params[:page]).per(6)
    end
  end
end
