class Category < ApplicationRecord
  has_ancestry
  has_many :posts, dependent: :destroy
  
  scope :sorted, -> { order(created_at: :desc) }
  scope :active, -> { where("posts.user_id IN (SELECT users.id FROM users WHERE users.is_deleted = 0)") }#boolean (0 = false, 1 = true)
  scope :default_order, -> { order("posts.created_at desc, posts.id desc") }
  scope :recent, -> { sorted.active }
  
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
