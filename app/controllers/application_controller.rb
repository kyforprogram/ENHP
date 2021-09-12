class ApplicationController < ActionController::Base
  
  
  private def ensure_post
    @post = Post.find(params[:post_id])
  end  
end
