class Users::CategoriesController < ApplicationController
before_action :authenticate_user!

  def show
    @parents = Category.where(ancestry: nil)
    @category = Category.find(params[:id])
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
  # カテゴリー検索機能----------------------------------------------------------------------------------------------------------
  def search
    @new_posts = Post.includes(:user, :category).recent
    @posts = []
    @category = Category.find_by(id: params[:id])
    if @category.ancestry == nil#第一階層-------------------------------------開始--------------------------------------------------
      category = Category.find_by(id: params[:id]).descendant_ids#親から検索rootは含まれない
      category << @category.id#@category.id = root.id
      if category.empty?
        @posts = Post.where(category_id: @category.id).order(created_at: :desc)
      else
        find_item(category)#110行目
      end
    else
      category = Category.find_by(id: params[:id]).descendant_ids#第二階層（親、子）-----------------開始---------------------------
      category << @category.id#@category.id = root.id
      find_item(category)#110行目
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

end
