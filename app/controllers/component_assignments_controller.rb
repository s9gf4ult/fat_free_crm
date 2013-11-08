class ComponentAssignmentsController < ApplicationController
  # POST
  def create
    @commercial_offer = CommercialOffer.find params[:commercial_offer][:id]
    @offer_component = OfferComponent.find params[:offer_component][:id]
    unless @commercial_offer.offer_components.include? @offer_component
      @commercial_offer.offer_components << @offer_component
    end
  end

  # DELETE
  def delete
    @commercial_offer = CommercialOffer.find params[:commercial_offer][:id]
    @offer_component = OfferComponent.find params[:offer_component][:id]
    if @commercial_offer.offer_components.include? @offer_component
      @commercial_offer.offer_components.delete @offer_component
    end
  end

  def move_up
  end

  def move_down
  end
end
