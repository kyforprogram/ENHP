class Users::LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comments_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    # 非同期通信をする場合は15行目だとエラーになる可能性があるのかもしれない
    # PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comments_params
  params.require(:like).permit(:comment)
  end
end
