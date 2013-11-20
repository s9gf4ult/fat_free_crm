class OfferComponentsController < EntitiesController
  # GET /offer_components
  # GET /offer_components.json
  def index
    @offer_components = OfferComponent

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offer_components }
    end
  end

  # GET /offer_components/1
  # GET /offer_components/1.json
  def show
    @offer_component = OfferComponent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offer_component }
    end
  end

  # GET /offer_components/new
  # GET /offer_components/new.json
  def new
    @offer_component = OfferComponent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offer_component }
    end
  end

  # GET /offer_components/1/edit
  def edit
    @offer_component = OfferComponent.find(params[:id])
  end

  # POST /offer_components
  # POST /offer_components.json
  def create
    @offer_component = OfferComponent.new(params[:offer_component])

    respond_to do |format|
      if @offer_component.save
        format.html { redirect_to @offer_component, notice: 'Offer component was successfully created.' }
        format.json { render json: @offer_component, status: :created, location: @offer_component }
      else
        format.html { render action: "new" }
        format.json { render json: @offer_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offer_components/1
  # PUT /offer_components/1.json
  def update
    @offer_component = OfferComponent.find(params[:id])

    respond_to do |format|
      if @offer_component.update_attributes(params[:offer_component])
        format.html { redirect_to @offer_component, notice: 'Offer component was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer_component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_components/1
  # DELETE /offer_components/1.json
  def destroy
    @offer_component = OfferComponent.find(params[:id])
    @offer_component.destroy

    respond_to do |format|
      format.html { redirect_to offer_components_url }
      format.json { head :no_content }
    end
  end

  # GET
  def get_copy
    @original_component = OfferComponent.find(params[:id])
    @offer_component = @original_component.dup
  end

end
