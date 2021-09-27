class Users::PostsController < ApplicationController
before_action :authenticate_user!
before_action :set_post, only: %i[show edit update destroy]
before_action :set_parents
before_action :index_post, only: %i[top index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "successfully."
    else
      render :new
    end
  end

  def index
    @posts = Post.includes(:category).recent.page(params[:page]).per(6)#recentはpost.rbの１８行目
  end

  def show
    @post_comment = PostComment.new
    unless ViewCount.find_by(user_id: current_user.id, post_id: @post.id)
    view_counts = ViewCount.new
    view_counts.user_id = current_user.id
    view_counts.post_id = @post.id
    view_counts.save
    end
    @post_comments = @post.post_comments.active
    @post_comments = Kaminari.paginate_array(@post_comments).page(params[:page]).per(6)
  end

  def edit
    unless @post.user == current_user
      redirect_to root_path, alert: "unexpect error"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "successfully."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  # お気に入り一覧ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  def likes
    likes = Like.where(user_id: current_user.id).pluck(:post_id)# ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @post_likes = Post.includes(:category).find(likes)# postsテーブルから、お気に入り登録済みのレコードを取得
    @post_likes = Kaminari.paginate_array(@post_likes).page(params[:page])
  end

  # ハッシュタグ機能ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  def hashtag
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
  end

  # カテゴリー機能ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  def top
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds = Category.find(params[:children_id]).children
        elsif params[:gcchildren_id]
          @parents = Category.where(id: params[:gcchildren_id])
        end
      end
    end
  end
  
  def search
    @posts = []
    @category = Category.find_by(id: params[:id])
    if @category.ancestry == nil#第一階層-------------------------------------開始--------------------------------------------------
      category = Category.find_by(id: params[:id]).descendant_ids#親から検索rootは含まれない
      category << @category.id#@category.id = root.id
      if category.empty?
        @posts = Post.where(category_id: @category.id).order(created_at: :desc)
      else
        find_item(category)
      end
    else
      category = Category.find_by(id: params[:id]).descendant_ids#第二階層（親、子）-----------------開始---------------------------
      category << @category.id#@category.id = root.id
      find_item(category)
    end
  end
  def find_item(category)
    category.each do |id|
      post_array = Post.where(category_id: id).order(created_at: :desc)
      if post_array.present?
        post_array.each do |post|
          if post.present?
            @posts.push(post)
            @posts = Kaminari.paginate_array(@posts).page(params[:page])
          end
        end
      end
    end
  end

  # before_action-------------------------------------------------------------------------------------
  def set_post
   @post = Post.includes(:user).find(params[:id])
  end
  def set_parents
    @parents = Category.where(ancestry: nil)
  end
  def index_post
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end

  private
  def post_params
    params.require(:post).permit(:title, :image, :introduction, :assignment, :target, :category_id)
  end

end
