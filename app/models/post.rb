class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :post_hashtag_relations
  has_many :likes, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  # 投稿に対する通知機能-----------------------------------------------------------
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(post_id: id, visited_id: user_id,action: 'like')
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_comment!(current_user, post_comment_id)
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(post_id: id, post_comment_id: post_comment_id, visited_id: visited_id, action: 'comment')
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  # ハッシュタグ機能---------------------------------------------------
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
