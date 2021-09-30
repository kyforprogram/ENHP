class Contact < ApplicationRecord


  validates :name, presence: true
  validates :email, presence: true
  validates :tel, presence: true
  validates :subject, presence: true, length: { in: 1..500 }
  validates :message, presence: true, length: { in: 1..500 }
end
