class Users::PostsController < ApplicationController
before_action :authenticate_user!, only: %i[new create show edit update destroy]
before_action :set_post, only: %i[show edit update destroy]
before_action :set_parents
before_action :index_post, only: %i[top index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
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

  def show
    @post_comment = PostComment.new
    unless ViewCount.find_by(user_id: current_user.id, post_id: @post.id)
    view_counts = ViewCount.new
    view_counts.user_id = current_user.id
    view_counts.post_id = @post.id
    view_counts.save
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def search
    @category = Category.find_by(id: params[:id])

    if @category.ancestry == nil
      category = Category.find_by(id: params[:id]).indirect_ids
      if category.empty?
        @posts = Post.where(category_id: @category.id).order(created_at: :desc)
      else
        @posts = []
        find_item(category)
      end

    elsif @category.ancestry.include?("/")
      @posts = Post.where(category_id: params[:id]).order(created_at: :desc)
    else
      category = Category.find_by(id: params[:id]).child_ids
      @posts = []
      find_item(category)
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :company_name, :image, :introduction, :assignment, :target, :category_id)
  end

  def set_post
   @post = Post.find(params[:id])
  end
  def set_parents
    @parents = Category.where(ancestry: nil)
  end
  def index_post
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def find_item(category)
    category.each do |id|
      post_array = Post.where(category_id: id).order(created_at: :desc)
      # find_by()メソッドで該当のレコードがなかった場合、itemオブジェクトに空の配列を入れないようにするための処理
      if post_array.present?
        post_array.each do |post|
          if post.present?
          # else
            # find_by()メソッドで該当のレコードが見つかった場合、@item配列オブジェクトにそのレコードを追加する
            @posts.push(post)
          end
        end
      end
    end
  end

end
