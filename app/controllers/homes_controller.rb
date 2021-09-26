class HomesController < ApplicationController

  def top
    @posts = Post.includes(:category, :user).order(created_at: :desc).limit(4)
    @categories = Category.where(ancestry: nil)
  end
end
