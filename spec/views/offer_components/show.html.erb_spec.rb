require 'spec_helper'

describe "offer_components/show" do
  before(:each) do
    @offer_component = assign(:offer_component, stub_model(OfferComponent,
      :name => "Name",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
