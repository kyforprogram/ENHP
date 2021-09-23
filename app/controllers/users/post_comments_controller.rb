class Users::PostCommentsController < ApplicationController
before_action :authenticate_user!
before_action :find_post, only: [:create, :destroy]

  def create
    comment = PostComment.new(post_comments_params)
    comment.user_id = current_user.id
    comment.post_id = @post.id
    comment.save
    @post.create_notification_comment!(current_user, comment.id)
    # redirect_to request.referer || post_path(post)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    #redirect_to request.referer || post_path(params[:post_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  private
  def post_comments_params
    params.require(:post_comment).permit(:comment)
  end
end
