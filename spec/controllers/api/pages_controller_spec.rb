require 'spec_helper'

describe Api::PagesController do

  describe 'create' do

    before do
      @issue = FactoryGirl.create :issue
      @page_title = 'test page'
    end
    def do_post
      post :create, :format => :json,
                    page: {title: @page_title,
                           page_nr: 1,
                           comment: 'some comment',
                           issue_id: issue_id}
    end

    context 'request with existing issue id' do

      let(:issue_id) { @issue.id }

      it 'should return OK' do
        do_post
        response.should be_success
      end

      it 'should create a page' do
        do_post
        page = Page.first
        page.title.should == @page_title
        page.page_nr.should == 1
      end

      it 'should add the page to the specified issue' do
        do_post
        @issue.pages.first.title.should == @page_title
      end

      it 'should return the new page id' do
        do_post
        json_response.should == { "page_id" => @issue.pages.first.id }
      end

    end

    context 'request with non-existiing issue id' do

      let(:issue_id) { 666 }

      it 'should return status 404' do
        do_post
        response.status.should == 404
      end

    end
  end
end