class Changepicturename < ActiveRecord::Migration
  def change
    rename_column :pictures, :avatar_uid, :image_uid
    rename_column :pictures, :avatar_name, :image_name
    rename_column :pictures, :avatar, :image
  end
end
