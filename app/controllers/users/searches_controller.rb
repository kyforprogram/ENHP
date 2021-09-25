class Users::SearchesController < ApplicationController

  def search
    @category = params[:category]
    search = params[:search]
    word = params[:word]

    if @category == "2"
      @post = Post.search(search, word)
      @post = Kaminari.paginate_array(@post).page(params[:page]).per(6)
    else
      @user = User.search(search, word)
      @user = Kaminari.paginate_array(@user).page(params[:page]).per(6)
    end
  end


end
