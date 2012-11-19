require 'spec_helper'

describe "pages/index" do
  before(:each) do
    assign(:pages, [
      stub_model(Page,
        :title => "Title",
        :company => "Company",
        :image => "Image",
        :comment => "Comment",
        :page_nr => 1
      ),
      stub_model(Page,
        :title => "Title",
        :company => "Company",
        :image => "Image",
        :comment => "Comment",
        :page_nr => 1
      )
    ])
  end

  it "renders a list of pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
