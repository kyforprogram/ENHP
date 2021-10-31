class Category < ApplicationRecord
  has_ancestry
  has_many :posts, dependent: :destroy
  
  def set_posts
    # 親カテゴリーの場合
    if self.root?
      start_id = self.indirects.first.id
      end_id = self.indirects.last.id
      posts = Post.where(category_id: start_id..end_id)
      return posts
  
      # 子カテゴリーの場合
    elsif self.has_children?
      start_id = self.children.first.id
      end_id = self.children.last.id
      posts = Post.where(category_id: start_id..end_id)
      return posts
  
      # 孫カテゴリーの場合
    else
      return self.posts
    end
  end
  
end
