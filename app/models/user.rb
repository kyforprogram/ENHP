class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image#画像refile用

  has_many :posts, dependent: :destroy

  has_many :post_comments, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :relationships, foreign_key: :following_id# フォロー取得
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id# フォロワー取得
  has_many :followings, through: :relationships, source: :follower# 自分がフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :following# 自分をフォローしている人
  def is_followed_by?(user)# フォローしてたらtrueを返す
    followings.include?(user)# find_byよりincludeの方がN＋１問題を解消できる
  end

  #DM機能アソシエーション-----------------------
  has_many :direct_messages, dependent: :destroy
  has_many :entries, dependent: :destroy

end
