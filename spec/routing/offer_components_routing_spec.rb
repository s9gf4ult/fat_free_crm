require "spec_helper"

describe OfferComponentsController do
  describe "routing" do

    it "routes to #index" do
      get("/offer_components").should route_to("offer_components#index")
    end

    it "routes to #new" do
      get("/offer_components/new").should route_to("offer_components#new")
    end

    it "routes to #show" do
      get("/offer_components/1").should route_to("offer_components#show", :id => "1")
    end

    it "routes to #edit" do
      get("/offer_components/1/edit").should route_to("offer_components#edit", :id => "1")
    end

    it "routes to #create" do
      post("/offer_components").should route_to("offer_components#create")
    end

    it "routes to #update" do
      put("/offer_components/1").should route_to("offer_components#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/offer_components/1").should route_to("offer_components#destroy", :id => "1")
    end

  end
end
