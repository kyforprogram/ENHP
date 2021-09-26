class HomesController < ApplicationController

  def top
    @posts = Post.includes(:category, :user).default_order.limit(4)
    @categories = Category.where(ancestry: nil)
  end
end
