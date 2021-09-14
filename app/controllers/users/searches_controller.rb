class Users::SearchesController < ApplicationController

  def search
    @category = params[:category]
    search = params[:search]
    word = params[:word]

    if @category == "2"
      @post = Post.search(search, word)
    else
      @user = User.search(search, word)
    end
  end
  
  
end
