require 'spec_helper'

describe "commercial_offers/show" do
  before(:each) do
    @commercial_offer = assign(:commercial_offer, stub_model(CommercialOffer,
      :name => "Name",
      :content => "MyText",
      :contact_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
