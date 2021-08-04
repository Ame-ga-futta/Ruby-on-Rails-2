class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :password_reset, confirmation: true
  validates :introduction, length: {maximum: 50}

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  mount_uploader :icon, IconUploader

end
