class DirectMessage < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: true
  validates :message, presence: true, length: {maximum: 100}
end
