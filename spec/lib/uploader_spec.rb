require 'spec_helper'
require 'uploader'

describe Uploader do

  describe 'create_base_address' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
    end
    context 'server starts with http' do
      it "doesn't prepend 'http'" do
        input = 'http://www.example.com/'
        addr = @uploader.create_base_address(input)
        addr[0..10].should == input[0..10]
      end
    end
    context 'server starts with https' do
      it "doesn't prepend anything" do
        input = 'https://www.example.com/'
        addr = @uploader.create_base_address(input)
        addr[0..10].should == input[0..10]
      end
    end
    context 'server does not start with http' do
      it "prepends 'http://'" do
        input = 'www.example.com/'
        addr = @uploader.create_base_address(input)
        addr[0..10].should == "http://#{input}"[0..10]
      end
    end
    context 'server has trailing "/"' do
      it 'creates valid url' do
        input = 'http://www.example.com/'
        addr = @uploader.create_base_address(input)
        addr.should == 'http://www.example.com/api'
      end
    end
    context 'server has no trailing "/"' do
      it 'creates valid url' do
        input = 'http://www.example.com'
        addr = @uploader.create_base_address(input)
        addr.should == 'http://www.example.com/api'
      end
    end
  end

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

  describe 'get_issue_data' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
    end

    let(:issue_date) { Time.now.strftime('%Y.%m') + '.01' }

    context 'User provides title and date' do
      before do
        STDIN.stubs(:gets).returns('mag title', '2014.12.24')
      end
      it 'returns user provided title and date' do
        @uploader.get_issue_data.should == ['mag title', '2014.12.24']
      end
    end
    context 'User provides title and invalid date' do
      before do
        STDIN.stubs(:gets).returns('mag title', '2014.24.12')
      end
      it 'returns user provided title and default date' do
        @uploader.get_issue_data.should == ['mag title', issue_date ]
      end
    end
    context 'User provides only title, no date' do
      before do
        STDIN.stubs(:gets).returns('mag title', "\n")
      end
      it 'returns user provided title and default date' do
        @uploader.get_issue_data.should == ['mag title', issue_date ]
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
        @uploader.create_page(1, 'path/to/027some_title_Done').should == 9
      end
    end

    context "image name doesn't include page nr" do
      it 'throws a StandardError' do
        expect { @uploader.create_page(1, '/path/to/no_page_nr_in_file_name') }.to raise_error StandardError
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
        @uploader.expects(:upload_to_aws).with(:a_pid, @image_file_name).returns(:a_url)
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
        @uploader.errors.first.should =~ /error message/
      end
    end
  end

  describe 'parse_name' do
    before do
      Uploader.any_instance.stubs(:read_image_dir).returns([])
      @uploader = Uploader.new
    end

    context 'filename has correct format' do

      it 'parses filenames starting with numbers like 001' do
        image_filename = '/Users/lukas/workspaces/nduoidep/page_images/2015jan-issues/001BacAi_TrungTinBaoHiem-Done.jpg'
        @uploader.parse_name( image_filename ).should == [1, 'BacAi_TrungTinBaoHiem']
      end

      it 'parses filenames starting with numbers like 011' do
        image_filename = '/Users/lukas/workspaces/nduoidep/page_images/2015jan-issues/011BacAi_TrungTinBaoHiem-Done.jpg'
        @uploader.parse_name( image_filename ).should == [11, 'BacAi_TrungTinBaoHiem']
      end

      it 'parses filenames starting with numbers like 111' do
        image_filename = '/Users/lukas/workspaces/nduoidep/page_images/2015jan-issues/111BacAi_TrungTinBaoHiem-Done.jpg'
        @uploader.parse_name( image_filename ).should == [111, 'BacAi_TrungTinBaoHiem']
      end

      it 'parses filenames starting with 000' do
        image_filename = '/Users/lukas/workspaces/nduoidep/page_images/2015jan-covers/000Cover-02_NOHOpharmacy-Done.jpg'
        @uploader.parse_name( image_filename ).should == [2, 'NOHOpharmacy']
      end

    end

    context 'filename has wrong format' do

      it 'throws an error if the filename does not start with a number' do
        image_filename = '/Users/lukas/workspaces/nduoidep/page_images/2015jan-issues/BacAi_TrungTinBaoHiem-Done.jpg'
        expect { @uploader.parse_name( image_filename ) }.to raise_error StandardError
      end

      it 'throws an error if the filenam starts with 000 but does not have another number' do
        image_filename = '/Users/lukas/workspaces/nduoidep/page_images/2015jan-covers/000Cover_NOHOpharmacy-Done.jpg'
        expect { @uploader.parse_name( image_filename ) }.to raise_error StandardError
      end

    end

  end

    describe 'run' do
    before do
      @images = %w[ path/to/ada.jpg path/to/bea.jpg path/to/cli.jpg]
      Uploader.any_instance.stubs(:read_image_dir).returns(@images)
      @uploader = Uploader.new
      @uploader.expects(:create_issue)
    end

    context 'no error happens' do
      before do
        @uploader.expects(:create_and_upload_page).times(@images.size)
      end
      it 'adds no error to error list' do
        expect { @uploader.run }.to_not change {@uploader.errors}
      end
    end
    context 'an error happens' do
      before do
        @uploader.stubs(:create_and_upload_page)
                 .raises(StandardError, 'error message')
                 .then.returns(1, 2)
      end
      it 'adds no error to error list' do
        expect { @uploader.run }.to change {
          @uploader.errors
        }.from([]).to(['error message'])
      end
    end


  end

end