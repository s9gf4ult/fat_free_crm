require 'spec_helper'

describe "offer_components/index" do
  before(:each) do
    assign(:offer_components, [
      stub_model(OfferComponent,
        :name => "Name",
        :content => "MyText"
      ),
      stub_model(OfferComponent,
        :name => "Name",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of offer_components" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
