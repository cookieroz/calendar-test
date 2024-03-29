class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :description, :apt_id, :image
  mount_uploader :image, ImageUploader

  belongs_to :apt

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload
    {
        "id" => id,
        "name" => read_attribute(:image),
        "size" => image.size,
        "url" => image.url,
        "thumbnail_url" => image.thumb.url,
        "delete_url" => picture_path(:id => id),
        "delete_type" => "DELETE"
    }
  end
end
