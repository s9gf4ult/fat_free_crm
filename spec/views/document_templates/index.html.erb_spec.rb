require 'spec_helper'

describe "document_templates/index" do
  before(:each) do
    assign(:document_templates, [
      stub_model(DocumentTemplate,
        :name => "Name",
        :content_before => "MyText",
        :content_after => "MyText"
      ),
      stub_model(DocumentTemplate,
        :name => "Name",
        :content_before => "MyText",
        :content_after => "MyText"
      )
    ])
  end

  it "renders a list of document_templates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
