class HomesController < ApplicationController

  def top
    @posts = Post.order(created_at: :desc)
    @categories = Category.where(ancestry: nil)
  end
end
