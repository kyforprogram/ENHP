class Users::PostCommentsController < ApplicationController

  def create
  end
  
  def destroy
  
  end

  private
  
  def post_comments_params
  params.require(:post_comment).permit(:comment)
  end
  
end
