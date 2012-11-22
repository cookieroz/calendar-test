class AddAptIdtoPictures < ActiveRecord::Migration
  def up
    add_column :pictures, :apt_id, :integer
  end

  def down
  end
end
