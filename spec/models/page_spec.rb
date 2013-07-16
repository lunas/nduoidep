require 'spec_helper'

describe Page do

  describe 'upload an image using carrierwave' do
    before do
      @page = Page.new( title: 'Last page', page_nr: 12 )
      @image_path = Rails.root.join('spec/fixtures/ada.jpeg')
    end

    it 'assigns the url to the image field' do
      @page.image = File.open(Rails.root.join('spec/fixtures/ada.jpeg'))
      @page.save
      @page.reload.url.should == @page.image.url
    end
  end

  describe 'url' do
    before do
      @page = Page.new( title: 'Last page', page_nr: 12 )
      @page.save
      @image_path = Rails.root.join('spec/fixtures/ada.jpeg')
    end

    context 'no carrierwave image uploaded' do
      context 'no url set' do
        it 'returns nil' do
          @page.url.should be_nil
        end
      end
      context 'url set' do
        before do
          @url = '/some/pict/ure.jpg'
          @page.update_attribute(:url, @url)
        end

        it 'returns the url' do
          @page.url.should == @url
        end
      end
    end

    context 'carrierwave image uploaded' do
      before do
        @page = create :page
      end

      context 'url is (for some reason) nil' do
        before do
          @page.update_attribute(:url, nil)
        end

        it 'returns the carrierwave url' do
          @page.url.should == @page.image.url
        end
      end

      context 'url is not nil' do
        it 'returns the carrierwave url' do
          @page.url.should == @page.image.url
        end
      end
    end
  end

end
