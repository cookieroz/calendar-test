class PicturesController < ApplicationController
  # GET /pictures
  # GET /pictures.json
  def index

    @apt = Apt.find(params[:apt_id])

    @pictures = @apt.pictures
    render :json => @pictures.collect { |p| p.to_jq_upload }.to_json

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
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
    #p_attr = params[:picture]
   # p_attr[:image] = params[:picture][:image].first if params[:picture][:image].class == Array

    @picture = Picture.new(params[:picture])
    #@picture.image = params[:picture][:path].shift

    #@apt = Apt.find(params[:apt_id])
    #@picture = @apt.pictures.build(p_attr)

    if @picture.save
      respond_to do |format|
        format.html {
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
    #@apt = Apt.find(params[:apt_id])
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :json => true }
    end
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
end
