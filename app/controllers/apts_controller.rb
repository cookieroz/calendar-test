class AptsController < ApplicationController
  # GET /apts
  # GET /apts.json
  def index
    @apts = Apt.all
    @pictures = Picture.all
    #render :json => @pictures.collect { |p| p.to_jq_upload }.to_json

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pictures.collect { |p| p.to_jq_upload }.to_json }
    end
  end

  # GET /apts/1
  # GET /apts/1.json
  def show
    @apt = Apt.find(params[:id])

    @reservations_by_start_date = @apt.reservations.group_by(&:start_date)
    @reservations_by_due_date = @apt.reservations.group_by(&:due_date)
    # @reservations_by_save_dates = @reservations.group_by(&:save_dates)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @day_ranges = :start_date..:due_date

    #@res_ranges = @apt.reservations.day_ranges(params[:start_date],
                                        #  params[:due_date])

    @picture = @apt.pictures.build
    @pictures = Picture.scoped(:conditions => [ 'apt_id = ?', @apt.id ] )
        #find(:all, :conditions  => [ 'gallery_id = ?', @gallery.id ])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @apt }
    end
  end

  # GET /apts/new
  # GET /apts/new.json
  def new
    @apt = Apt.new
    @apt.reservations.build
    @object_new = Picture.new    # needed for form_for --> gets the path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @apt }
    end
  end

  # GET /apts/1/edit
  def edit
    @apt = Apt.find(params[:id])
    @apt.reservations.build
    @object_new = Picture.new
  end

  # POST /apts
  # POST /apts.json
  def create
    apt_date = params[:apt]
    picture_ids = apt_date.delete :picture_ids
    @apt = Apt.new(apt_date)

    respond_to do |format|
      if @apt.save
        picture_ids.split(',').each do |id|
          pic = Picture.find id
          pic.update_attributes(apt_id: @apt.id)
        end

        format.html { redirect_to @apt, notice: 'Apt was successfully created.' }
        format.json { render json: @apt, status: :created, location: @apt }
      else
        format.html { render action: "new" }
        format.json { render json: @apt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apts/1
  # PUT /apts/1.json
  def update
    @apt = Apt.find(params[:id])

    respond_to do |format|
      if @apt.update_attributes(params[:apt])
        format.html { redirect_to @apt, notice: 'Apt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @apt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apts/1
  # DELETE /apts/1.json
  def destroy
    @apt = Apt.find(params[:id])
    @apt.destroy

    respond_to do |format|
      format.html { redirect_to apts_url }
      format.json { head :no_content }
    end
  end
end
