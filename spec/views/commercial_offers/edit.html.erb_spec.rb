require 'spec_helper'

describe "commercial_offers/edit" do
  before(:each) do
    @commercial_offer = assign(:commercial_offer, stub_model(CommercialOffer,
      :name => "MyString",
      :content => "MyText",
      :contact_id => 1
    ))
  end

  it "renders the edit commercial_offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", commercial_offer_path(@commercial_offer), "post" do
      assert_select "input#commercial_offer_name[name=?]", "commercial_offer[name]"
      assert_select "textarea#commercial_offer_content[name=?]", "commercial_offer[content]"
      assert_select "input#commercial_offer_contact_id[name=?]", "commercial_offer[contact_id]"
    end
  end
end
