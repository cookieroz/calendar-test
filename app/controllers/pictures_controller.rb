class PicturesController < ApplicationController
  
  respond_to :js, :html, :json
  
  before_filter :load_apt
  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = @apt.pictures
    render :json => @pictures.collect { |p| p.to_jq_upload }.to_json
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @apt = Apt.find(params[:apt_id])
    @picture = @apt.pictures.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @apt = Apt.find(params[:apt_id])

    @picture = @apt.pictures.find(params[:id])
    # @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    logger = Logger.new('log/debug.log')
    logger.info('-------Log for create image-------')
    #logger.info(params[:picture].to_s)
    @picture = @apt.pictures.new
    
    @picture.image = params[:picture][:path].shift
    if @picture.save
      logger.info('Saved')
      logger.info(@picture.image.url.to_s)
      respond_to do |format|
        format.html { #(html response is for browsers using iframe sollution)
          render :json => [@picture.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@picture.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

    @apt = Apt.find(params[:apt_id])

    @picture = @apt.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to apt_path(@apt), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    render :json => true
  end

  def make_default
    @picture = Picture.find(params[:id])
    @apt = Apt.find(params[:apt_id])

    @apt.cover = @picture.id
    @apt.save

    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def load_apt
    @apt = Apt.find(params[:apt_id])
  end
  
end