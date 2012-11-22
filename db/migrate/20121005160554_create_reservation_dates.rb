class CreateReservationDates < ActiveRecord::Migration
  def change
    create_table :reservation_dates do |t|
      t.date :save_date
      t.timestamps
    end
  end
end
