require 'spec_helper'
require 'page_uploader'
require 'carrierwave/test/matchers'

describe PageUploader do
  include CarrierWave::Test::Matchers

  before do
    @uploader = PageUploader.new
    path = "#{File.dirname(__FILE__)}/../fixtures/ada.jpeg"
    @file = File.open(path)
  end

  after do
    @uploader.remove!
  end

  describe 'store' do
    it 'uploads file to page_id specific path' do
      @uploader.page_id = 9
      @uploader.store!( @file )
      (@uploader.url =~ /9/).should > 0
    end
  end

  #context 'the small version' do
  #  it "should scale down a landscape image to fit within 200 by 200 pixels" do
  #    @uploader.small.should be_no_larger_than(200, 200)
  #  end
  #end

end