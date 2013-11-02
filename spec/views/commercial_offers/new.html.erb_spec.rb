require 'spec_helper'

describe "commercial_offers/new" do
  before(:each) do
    assign(:commercial_offer, stub_model(CommercialOffer,
      :name => "MyString",
      :content => "MyText",
      :contact_id => 1
    ).as_new_record)
  end

  it "renders new commercial_offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", commercial_offers_path, "post" do
      assert_select "input#commercial_offer_name[name=?]", "commercial_offer[name]"
      assert_select "textarea#commercial_offer_content[name=?]", "commercial_offer[content]"
      assert_select "input#commercial_offer_contact_id[name=?]", "commercial_offer[contact_id]"
    end
  end
end
