class Reservation < ApplicationRecord
  validates :start_date, date_before: true
  validates :end_date, date_before: true
  validates :people, presence: true, numericality: true

  belongs_to :user, optional: true
  belongs_to :room, optional: true
end
