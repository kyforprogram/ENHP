class HomesController < ApplicationController

  def top
    @posts = Post.includes(:category, :user).recent.limit(4)
    @categories = Category.where(ancestry: nil)
  end
end
