class Users::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comments_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    comment.save
    redirect_to request.referer || post_path(post)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer || post_path(params[:post_id])
  end

  private

  def post_comments_params
  params.require(:post_comment).permit(:comment)
  end

end
