class CreateApts < ActiveRecord::Migration
  def change
    create_table :apts do |t|
      t.string :apt_name
      t.text :body

      t.timestamps
    end
  end
end
