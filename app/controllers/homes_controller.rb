class HomesController < ApplicationController
  
  def top
    @categories = Category.where(ancestry: nil)
  end
end
