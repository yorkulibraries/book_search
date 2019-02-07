class Admin::SearchTicketsController <  Admin::AuthorizedBaseController
  before_action :set_search_ticket, only: [:show, :edit, :update, :destroy]

  # GET /admin/search_tickets
  # GET /admin/search_tickets.json
  def index
    @search_tickets = SearchTicket.all
  end

  # GET /admin/search_tickets/1
  # GET /admin/search_tickets/1.json
  def show
  end

  # GET /admin/search_tickets/new
  def new
    @search_ticket = SearchTicket.new
  end

  # GET /admin/search_tickets/1/edit
  def edit
  end

  # POST /admin/search_tickets
  # POST /admin/search_tickets.json
  def create
    @search_ticket = SearchTicket.new(search_ticket_params)

    respond_to do |format|
      if @search_ticket.save
        format.html { redirect_to admin_search_tickets_path, notice: 'Search ticket was successfully created.' }
        format.json { render :show, status: :created, location: admin_search_ticket_path(@search_ticket) }
      else
        format.html { render :new }
        format.json { render json: @search_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/search_tickets/1
  # PATCH/PUT /admin/search_tickets/1.json
  def update
    respond_to do |format|
      if @search_ticket.update(search_ticket_params)
        format.html { redirect_to admin_search_ticket_path(@search_ticket), notice: 'Search ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_search_tickets_path(@search_ticket) }
      else
        format.html { render :edit }
        format.json { render json: @search_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/search_tickets/1
  # DELETE /admin/search_tickets/1.json
  def destroy
    @search_ticket.destroy
    respond_to do |format|
      format.html { redirect_to admin_search_tickets_url, notice: 'Search ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_ticket
      @search_ticket = SearchTicket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_ticket_params
      params.require(:search_ticket).permit(:patron_id, :location_id, :item_id, :item_callnumber, :item_title, :item_author, :item_volume, :item_issue, :item_year, :item_location, :note, :resolution, :status, :assigned_to_id)
    end
end
