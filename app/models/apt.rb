class Apt < ActiveRecord::Base
   attr_accessible :apt_name, :body, :reservations_attributes,
                   :pictures_attributes

  has_many :reservations, :dependent => :destroy
  has_many :pictures, :dependent => :destroy

  accepts_nested_attributes_for :reservations, allow_destroy: true
  accepts_nested_attributes_for :pictures, allow_destroy: true
end
