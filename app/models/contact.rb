class Contact < ApplicationRecord


  validates :name, presence: true
  validates :email, presence: true
  validates :tel, presence: true
  validates :subject, presence: true
  validates :message, presence: true
end
