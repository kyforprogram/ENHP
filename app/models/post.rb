class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # いいね機能----------------------------------------
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  # 検索機能star--------------------------------------
  def self.search(word)
    if search == "perfect_match"#完全一致
      @post = Post.where("title LIKE? OR company_name LIKE OR target LIKE", "#{word}","#{word}","#{word}")
    elsif search == "forward_match"#前一致
      @post = Post.where("title LIKE? OR company_name LIKE OR target LIKE", "#{word}%","#{word}%","#{word}%")
    elsif search == "backward_match"#後ろ一致
      @post = Post.where("title LIKE? OR company_name LIKE OR target LIKE", "%#{word}","%#{word}","%#{word}")
    elsif search == "patial_match"#部分一致
      @post = Post.where("title LIKE? OR company_name LIKE OR target LIKE", "%#{word}%","%#{word}%","%#{word}%")
    else
      @post = Post.all
    end
  end
end
