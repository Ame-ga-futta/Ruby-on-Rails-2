class AddPasswordResetToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_reset, :string
    add_column :users, :password_reset_confirmation, :string
  end
end
