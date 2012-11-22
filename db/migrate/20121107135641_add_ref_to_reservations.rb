class AddRefToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :apt_id, :integer
  end
end
