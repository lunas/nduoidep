require 'spec_helper'

describe "pages/show" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :title => "Title",
      :company => "Company",
      :image => "Image",
      :comment => "Comment",
      :page_nr => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Company/)
    rendered.should match(/Image/)
    rendered.should match(/Comment/)
    rendered.should match(/1/)
  end
end
