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

  # PUT
  def attach_component
    @commercial_offer = CommercialOffer.find params[:commercial_offer_id]
    @offer_component = OfferComponent.find params[:offer_component_id]
    unless @commercial_offer.offer_components.include? @offer_component
      ComponentAssignment.create :offer_component => @offer_component, :commercial_offer => @commercial_offer
      respond_to do |format|
        format.html do
          redirect_to @commercial_offer, :notice => "Offer component attached"
        end
      end
    end
  end

  def deattach_component
    @commercial_offer = CommercialOffer.find params[:commercial_offer_id]
    @offer_component = OfferComponent.find params[:offer_component_id]
    if @commercial_offer.offer_components.include? @offer_component
      ComponentAssignment.destroy_all(:commercial_offer => @commercial_offer,
                                      :offer_component => @offer_component)
      respond_to do |format|
        format.html do
          redirect_to @commercial_offer, :notice => "Offer component detached"
        end
      end
    end
  end

    
  
end
