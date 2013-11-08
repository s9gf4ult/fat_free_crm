class ComponentAssignmentsController < ApplicationController
  # POST
  def create
    @commercial_offer = CommercialOffer.find params[:commercial_offer][:id]
    @offer_component = OfferComponent.find params[:offer_component][:id]
    unless @commercial_offer.offer_components.include? @offer_component
      m = ComponentAssignment
        .where(:commercial_offer_id => @commercial_offer.id)
        .maximum(:order_value) || 1
      ca = ComponentAssignment.create(:commercial_offer_id => @commercial_offer.id,
                                      :offer_component_id => @offer_component.id,
                                      :order_value => m)
    end
    respond_to do |format|
      format.html do
        redirect_to(edit_components_commercial_offer_path(@commercial_offer))
      end
    end
  end

  # DELETE
  def destroy
    @ca = ComponentAssignment.find params[:id]
    @commercial_offer = @ca.commercial_offer
    @offer_component = @ca.offer_component
    @commercial_offer.offer_components.delete @offer_component
    respond_to do |format|
      format.html do
        redirect_to(edit_components_commercial_offer_path(@commercial_offer))
      end
    end
  end

  def move_up
  end

  def move_down
  end
end
