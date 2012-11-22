class ReservationsController < ApplicationController
  require 'date'

	def index
		@reservations = Reservation.all
	end

	def show
		@reservation = Reservation.find(params[:id])

    #@reservations_by_start_date = @reservations.group_by(&:start_date)
    #@reservations_by_due_date = @reservations.group_by(&:due_date)
    # @reservations_by_save_dates = @reservations.group_by(&:save_dates)
    #@date = params[:date] ? Date.parse(params[:date]) : Date.today

    #@day_ranges = @reservation.day_ranges(params[:start_date],
                                         #params[:due_date])

    #@dates_range = Reservation.dates_range(@day_ranges)

    #@reservation_days = Reservation.dates_range(@dates_range)
	end

	def new
		@reservation = Reservation.new
    @object_new = Picture.new    # needed for form_for --> gets the path
	end

	def create
		@reservation = Reservation.new(params[:reservation])
		if @reservation.save
			redirect_to @reservation, notice: "Created reservation."
		else
			render :new
		end
	end

	def edit
		@reservation = Reservation.find(params[:id])
	end

	def update
		@reservation = Reservation.find(params[:id])
		if @reservation.update_attributes(params[:reservation])
			redirect_to @reservation, notice: "Updated reservation."
		else
			render :edit
		end
  end

  private
  def res_dates
    @reservation_dates ||= Reservation.find_by_start_date(params[:start_date])
  end
end