class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :uniqname
      t.string :name
      t.date :start_date
      t.date :due_date
      t.text :description

      t.timestamps
    end
  end
end
