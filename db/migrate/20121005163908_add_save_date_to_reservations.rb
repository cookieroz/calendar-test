class AddSaveDateToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :save_date, :date
  end
end
