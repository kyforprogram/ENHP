class HomesController < ApplicationController

  def top
    @posts = Post.includes(:category, :user).order("posts.created_at desc, posts.id desc").limit(4)
    @categories = Category.where(ancestry: nil)
  end
end
