class Room < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  validates :introduction, presence: true, length: {maximum: 100}
  validates :price, presence: true, numericality: true
  validates :address, presence: true, length: {maximum: 30}
  validates :image, presence: true

  belongs_to :user, optional: true
  has_many :reservations, dependent: :destroy

  mount_uploader :image, RoomUploader

end
