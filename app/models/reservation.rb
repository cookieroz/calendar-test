class Reservation < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :start_date,
                  :uniqname, :save_date

  has_many :events

  belongs_to :apt

  include CalendarHelper

  #def self.day_ranges(start, finish)
  #  drange = Date.parse(start)..Date.parse(finish)

   # drange.each do |day|
   #   puts day
   # end
  #end

  #day_range = (Date.parse(:start_date)..Date.parse(:due_date))

  def self.dates_range(day_range)
    day_range.each do |day|
       puts day
    end
  end

  #scope :starts_on_days, lambda {|start_date, end_date|  where(:start_date => start_date..end_date)}

  #before_save get_date_range

  #def get_date_range
  #  range = :start_date..:due_date
  #  @reservation_dates
  #end

  ## For single or multiple reservations
  # Checks that the equipment model is available from start date to due date
  # Not called on overdue, missed, checked out, or checked in Reservations
  # because this would double count the reservations. all_res is only cart
  # reservations but if there are too many reserved reservations, it will still
  # return false because available? will return less than 0
 # def available?(reservations = [])
 #   return true if self.class == Reservation && self.status != 'reserved'
 #   all_res = reservations.dup
 #   all_res << self if self.class != Reservation
 #   all_res.uniq!
 #   eq_objects_needed = same_model_count(all_res)
 #   if equipment_model.num_available(start_date, due_date) < eq_objects_needed
 #     errors.add(:base, equipment_model.name + " is not available for the full time period requested")
 #     return false
 #   end
 #   return true
 # end
end
