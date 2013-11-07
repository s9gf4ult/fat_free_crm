class CommercialOffersController < EntitiesController
  # GET /commercial_offers
  # GET /commercial_offers.json
  def index
    @commercial_offers = CommercialOffer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commercial_offers }
    end
  end

  # GET /commercial_offers/1
  # GET /commercial_offers/1.json
  def show
    @commercial_offer = CommercialOffer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commercial_offer }
    end
  end

  # GET /commercial_offers/new
  # GET /commercial_offers/new.json
  def new
    @commercial_offer = CommercialOffer.new
    # @contact = Contact.new
    cid = params[:contact_id]
    @contact = Contact.find cid if cid
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commercial_offer }
    end
  end

  # GET /commercial_offers/1/edit
  def edit
    @commercial_offer = CommercialOffer.find(params[:id])
  end

  # POST /commercial_offers
  # POST /commercial_offers.json
  def create
    @commercial_offer = CommercialOffer.new(params[:commercial_offer])
    @contact = Contact.find params[:commercial_offer][:contact_id]
    @commercial_offer.contact = @contact

    respond_to do |format|
      if @commercial_offer.save
        format.html { redirect_to @commercial_offer, notice: 'Commercial offer was successfully created.' }
        format.json { render json: @commercial_offer, status: :created, location: @commercial_offer }
      else
        format.html { render action: "new" }
        format.json { render json: @commercial_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commercial_offers/1
  # PUT /commercial_offers/1.json
  def update
    @commercial_offer = CommercialOffer.find(params[:id])

    respond_to do |format|
      if @commercial_offer.update_attributes(params[:commercial_offer])
        format.html { redirect_to @commercial_offer, notice: 'Commercial offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commercial_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commercial_offers/1
  # DELETE /commercial_offers/1.json
  def destroy
    @commercial_offer = CommercialOffer.find(params[:id])
    @commercial_offer.destroy

    respond_to do |format|
      format.html { redirect_to commercial_offers_url }
      format.json { head :no_content }
    end
  end

  # GET
  def edit_components
    @commercial_offer = CommercialOffer.find params[:id]
  end

  # # POST
  # def manage_component
  #   if params[:attach]
  #     attach_component
  #   elsif params[:detach]
  #     detach_component
  #   end
  # end

  # POST
  def component_up

  end
  # POST
  def component_down

  end

  # POST
  def attach_component
    cid = params[:offer_component][:id]
    if cid
      @commercial_offer = CommercialOffer.find params[:id]
      @offer_component = OfferComponent.find cid
      unless @commercial_offer.offer_components.include? @offer_component
        @commercial_offer.offer_components << @offer_component
        respond_to do |format|
          format.html do
            redirect_to edit_components_commercial_offer_path(@commercial_offer), :notice => "Offer component attached"
          end
        end
      end
    else
      head 200
    end
  end
  
  # POST
  def detach_component
    cid = params[:offer_component][:id]
    if cid
      @commercial_offer = CommercialOffer.find params[:id]
      @offer_component = OfferComponent.find cid
      if @commercial_offer.offer_components.include? @offer_component
        @commercial_offer.offer_components.delete @offer_component
        respond_to do |format|
          format.html do
            redirect_to edit_components_commercial_offer_path(@commercial_offer), :notice => "Offer component detached"
          end
        end
      end
    else
      head 200
    end
  end
end
