class Admin::SearchAreasController < ApplicationController
  before_action :set_search_area, only: [:show, :edit, :update, :destroy]

  # GET /search_areas
  # GET /search_areas.json
  def index
    @search_areas = SearchArea.all
  end

  # GET /search_areas/1
  # GET /search_areas/1.json
  def show
  end

  # GET /search_areas/new
  def new
    @search_area = SearchArea.new
  end

  # GET /search_areas/1/edit
  def edit
  end

  # POST /search_areas
  # POST /search_areas.json
  def create
    @search_area = SearchArea.new(search_area_params)

    respond_to do |format|
      if @search_area.save
        format.html { redirect_to @search_area, notice: 'Search area was successfully created.' }
        format.json { render :show, status: :created, location: @search_area }
      else
        format.html { render :new }
        format.json { render json: @search_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_areas/1
  # PATCH/PUT /search_areas/1.json
  def update
    respond_to do |format|
      if @search_area.update(search_area_params)
        format.html { redirect_to @search_area, notice: 'Search area was successfully updated.' }
        format.json { render :show, status: :ok, location: @search_area }
      else
        format.html { render :edit }
        format.json { render json: @search_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_areas/1
  # DELETE /search_areas/1.json
  def destroy
    @search_area.destroy
    respond_to do |format|
      format.html { redirect_to search_areas_url, notice: 'Search area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_area
      @search_area = SearchArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_area_params
      params.require(:search_area).permit(:name, :location_id, :primary)
    end
end
