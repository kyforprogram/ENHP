class Hashtag < ApplicationRecord

  has_many :post_hashtag_relations, dependent: :destroy
  has_many :posts, through: :post_hashtag_relations

  validates :hashname, presence: true, length: { maximum: 50 }
end
