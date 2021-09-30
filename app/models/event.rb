class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { in: 1..75 }
  validates :body, presence: true, length: { in: 1..200 }

end
