class AddRoomdateToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :room_image, :string
    add_column :reservations, :room_name, :string
    add_column :reservations, :room_introduction, :string
    add_column :reservations, :room_total_price, :integer
  end
end
