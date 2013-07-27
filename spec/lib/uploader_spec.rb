require 'spec_helper'
require 'uploader'

describe Uploader do

  describe 'read_image_dir' do
    before do
      path = "#{File.dirname(__FILE__)}/../fixtures/page_images"
      @uploader = Uploader.new(path)
    end

    it 'returns an array of all file names matching the default file pattern' do
      images = @uploader.images
      images.each { |img| (img =~ /^\/.+\.jpg$/).present?}
      images.size.should == 2
    end
  end

  describe 'create_issue' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
      @uploader.stubs(:get_issue_data).returns(['Nguoi Dep March', '2013-03-01'])
    end

    context 'server responds with valid issue_id' do
      before do
        stub_request(:post,/issues/ ).with(body: {issue: {title: /.*/, date: /.*/}})
        .to_return(status: 200, body: {issue_id: 9}.to_json)
      end

      it 'returns the issue_id' do
        @uploader.create_issue.should == 9
      end
    end
    context 'server returns error response' do
      before do
        stub_request(:post,/issues/ ).with(body: {issue: {title: /.*/, date: /.*/}})
        .to_return(status: 500, body: {error: 'sumting wong'}.to_json)
      end

      it 'throws a StandardError' do
        expect { @uploader.create_issue }.to raise_error StandardError
      end
    end

    context 'server returns status 200, but no valid issue_id' do
      before do
        stub_request(:post,/issues/ ).with(body: {issue: {title: /.*/, date: /.*/}})
        .to_return( status: 200, body: {error: 'no id'} )
      end

      it 'throws a StandardError' do
        expect { @uploader.create_issue }.to raise_error StandardError
      end
    end
  end

  describe 'create_page' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
    end

    context 'server responds with valid page_id' do
      before do
        stub_request(:post, /pages/ ).with(body: {page: {issue_id: 1, page_nr: 27, title: /.*/}})
        .to_return(status: 200, body: {page_id: 9}.to_json)
      end

      it 'returns the page_id' do
        @uploader.create_page(1, '027some_title_Done').should == 9
      end
    end

    context "image name doesn't include page nr" do
      it 'throws a StandardError' do
        expect { @uploader.create_page(1, 'no_page_nr_in_file_name') }.to raise_error StandardError
      end
    end

    context 'server returns error response' do
      before do
        stub_request(:post, /pages/ ).with(body: {page: {issue_id: 1, page_nr: 27, title: /.*/}})
        .to_return(status: 500, body: {error: 'sumting wong'}.to_json)
      end

      it 'throws a StandardError' do
        expect { @uploader.create_page(1, '027some_title_Done') }.to raise_error StandardError
      end
    end

    context 'server returns status 200, but no valid issue_id' do
      before do
        stub_request(:post, /pages/ ).with(body: {page: {issue_id: 1, page_nr: 27, title: /.*/}})
        .to_return( status: 200, body: {error: 'no id'} )
      end

      it 'throws a StandardError' do
        expect {  @uploader.create_page(1, '027some_title_Done') }.to raise_error StandardError
      end
    end
  end

  describe 'update_page' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
    end

    context 'server responds with 200' do
      before do
        stub_request(:put, /pages\/1/ ).with(body: {url: /.*/})
        .to_return(status: 200, body: {message: 'ok'} )
      end

      it 'returns the page_id' do
        expect {@uploader.update_page(1, 'some/url') }.to_not raise_error
      end
    end

    context 'server responds with an error' do
      before do
        stub_request(:put, /pages\/1/ ).with(body: {url: /.*/})
        .to_return(status: 500, body: {message: 'sum ting wong'} )
      end

      it 'throws a standard error' do
        expect {@uploader.update_page(1, 'some/url') }.to raise_error
      end
    end
  end

  describe 'upload_to_aws' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
      @image_file_name = "#{File.dirname(__FILE__)}/../fixtures/ada.jpeg"
    end

    it 'returns the image url which contains the page_id' do
      url = @uploader.upload_to_aws(9, @image_file_name)
      (url =~ /9/).should > 0
      (url =~ /ada.jpeg/).should > 0
    end
  end

  describe 'create_and_upload_page' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
      @image_file_name = "#{File.dirname(__FILE__)}/../fixtures/ada.jpeg"
    end

    context 'no error happens' do
      before do
        @uploader.expects(:create_page).with(1, @image_file_name).returns(:a_pid)
        @uploader.expects(:upload).with(:a_pid, @image_file_name).returns(:a_url)
        @uploader.expects(:update_page).with(:a_pid, :a_url)
      end
      it 'adds no errors to the error list' do
        @uploader.create_and_upload_page(1, @image_file_name)
        @uploader.errors.size.should == 0
      end
    end

    context 'an error happens' do
      before do
        @uploader.stubs(:create_page).raises(StandardError, 'error message')
      end
      it 'adds no errors to the error list' do
        @uploader.create_and_upload_page(1, @image_file_name)
        @uploader.errors.size.should == 1
        @uploader.errors.first.should == 'error message'
      end
    end

  end

end