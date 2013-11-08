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
    redirect_to_commercial_offer
  end

  # DELETE
  def destroy
    @ca = ComponentAssignment.find params[:id]
    @commercial_offer = @ca.commercial_offer
    @offer_component = @ca.offer_component
    @commercial_offer.offer_components.delete @offer_component
    redirect_to_commercial_offer
  end

  def move_up
    @component_assignment = ComponentAssignment.find params[:id]
    @commercial_offer = @component_assignment.commercial_offer
    @component_assignment.move_up
    redirect_to_commercial_offer
  end

  def move_down
    @component_assignment = ComponentAssignment.find params[:id]
    @commercial_offer = @component_assignment.commercial_offer
    @component_assignment.move_down
    redirect_to_commercial_offer
  end

  private

  def redirect_to_commercial_offer
    respond_to do |format|
      format.html do
        redirect_to edit_components_commercial_offer_path(@commercial_offer)
      end
    end
  end

end
