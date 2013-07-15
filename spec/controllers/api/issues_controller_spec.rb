require 'spec_helper'

describe Api::IssuesController do

  describe 'create' do

    def do_post
      post :create, :format => :json, issue: {title: 'july', date: '2013-07-14'}
    end

    it 'should return OK' do
      do_post
      response.should be_success
    end

    it 'should create an issue' do
      do_post
      issue = Issue.first
      issue.title.should == 'july'
    end

    it 'should return the new issue id' do
      do_post
      json_response.should == { "issue_id" => Issue.first.id }
    end
  end
end