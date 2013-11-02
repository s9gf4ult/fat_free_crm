require "spec_helper"

describe CommercialOffersController do
  describe "routing" do

    it "routes to #index" do
      get("/commercial_offers").should route_to("commercial_offers#index")
    end

    it "routes to #new" do
      get("/commercial_offers/new").should route_to("commercial_offers#new")
    end

    it "routes to #show" do
      get("/commercial_offers/1").should route_to("commercial_offers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/commercial_offers/1/edit").should route_to("commercial_offers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/commercial_offers").should route_to("commercial_offers#create")
    end

    it "routes to #update" do
      put("/commercial_offers/1").should route_to("commercial_offers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/commercial_offers/1").should route_to("commercial_offers#destroy", :id => "1")
    end

  end
end
