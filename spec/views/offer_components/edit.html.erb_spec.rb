require 'spec_helper'

describe "offer_components/edit" do
  before(:each) do
    @offer_component = assign(:offer_component, stub_model(OfferComponent,
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit offer_component form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offer_component_path(@offer_component), "post" do
      assert_select "input#offer_component_name[name=?]", "offer_component[name]"
      assert_select "textarea#offer_component_content[name=?]", "offer_component[content]"
    end
  end
end
