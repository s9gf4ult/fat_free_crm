require 'spec_helper'

describe "commercial_offers/index" do
  before(:each) do
    assign(:commercial_offers, [
      stub_model(CommercialOffer,
        :name => "Name",
        :content => "MyText",
        :contact_id => 1
      ),
      stub_model(CommercialOffer,
        :name => "Name",
        :content => "MyText",
        :contact_id => 1
      )
    ])
  end

  it "renders a list of commercial_offers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
