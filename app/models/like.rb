class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # いいねは一つの投稿にしかできないようにする
  validates_uniqueness_of :post_id, scope: :user_id
end
