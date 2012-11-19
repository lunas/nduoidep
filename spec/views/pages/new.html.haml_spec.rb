require 'spec_helper'

describe "pages/new" do
  before(:each) do
    assign(:page, stub_model(Page,
      :title => "MyString",
      :company => "MyString",
      :image => "MyString",
      :comment => "MyString",
      :page_nr => 1
    ).as_new_record)
  end

  it "renders new page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pages_path, :method => "post" do
      assert_select "input#page_title", :name => "page[title]"
      assert_select "input#page_company", :name => "page[company]"
      assert_select "input#page_image", :name => "page[image]"
      assert_select "input#page_comment", :name => "page[comment]"
      assert_select "input#page_page_nr", :name => "page[page_nr]"
    end
  end
end
