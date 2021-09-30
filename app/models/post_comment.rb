class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  scope :active, -> { where("post_comments.user_id IN (SELECT users.id FROM users WHERE users.is_deleted = 0)") }#boolean (0 = false, 1 = true)

  validates :comment, presence: true, length: { in: 1..200 }
end
