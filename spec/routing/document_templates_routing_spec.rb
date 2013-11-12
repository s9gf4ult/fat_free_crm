require "spec_helper"

describe DocumentTemplatesController do
  describe "routing" do

    it "routes to #index" do
      get("/document_templates").should route_to("document_templates#index")
    end

    it "routes to #new" do
      get("/document_templates/new").should route_to("document_templates#new")
    end

    it "routes to #show" do
      get("/document_templates/1").should route_to("document_templates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/document_templates/1/edit").should route_to("document_templates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/document_templates").should route_to("document_templates#create")
    end

    it "routes to #update" do
      put("/document_templates/1").should route_to("document_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/document_templates/1").should route_to("document_templates#destroy", :id => "1")
    end

  end
end
