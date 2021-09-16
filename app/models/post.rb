class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :post_hashtag_relations
  has_many :likes, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  
  
  # ハッシュタグ機能----------------------------------
  after_create do
    post = Post.find_by(id: self.id)
    hashtags = self.target.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post.hashtags = []
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))#小文字化し＃を削除の後hashnameに代入
      post.hashtags << tag
    end
  end
  before_update do
    post = Post.find_by(id: self.id)
    post.target.clear
    hashtags = self.target.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.target << tag
    end
  end
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
