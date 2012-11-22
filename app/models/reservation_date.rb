class ReservationDate < ActiveRecord::Base
  attr_accessible :save_date

  belongs_to :reservation
end
