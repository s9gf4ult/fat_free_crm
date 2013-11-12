require 'spec_helper'

describe "document_templates/edit" do
  before(:each) do
    @document_template = assign(:document_template, stub_model(DocumentTemplate,
      :name => "MyString",
      :content_before => "MyText",
      :content_after => "MyText"
    ))
  end

  it "renders the edit document_template form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", document_template_path(@document_template), "post" do
      assert_select "input#document_template_name[name=?]", "document_template[name]"
      assert_select "textarea#document_template_content_before[name=?]", "document_template[content_before]"
      assert_select "textarea#document_template_content_after[name=?]", "document_template[content_after]"
    end
  end
end
