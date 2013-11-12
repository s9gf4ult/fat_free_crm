require 'spec_helper'

describe "document_templates/new" do
  before(:each) do
    assign(:document_template, stub_model(DocumentTemplate,
      :name => "MyString",
      :content_before => "MyText",
      :content_after => "MyText"
    ).as_new_record)
  end

  it "renders new document_template form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", document_templates_path, "post" do
      assert_select "input#document_template_name[name=?]", "document_template[name]"
      assert_select "textarea#document_template_content_before[name=?]", "document_template[content_before]"
      assert_select "textarea#document_template_content_after[name=?]", "document_template[content_after]"
    end
  end
end
