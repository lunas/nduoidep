# encoding: utf-8

class PageUploader < CarrierWave::Uploader::Base

  attr_accessor :page_id

  def store_dir
    raise 'page_id not set' if @page_id.nil?
    "uploads/page/image/#{@page_id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  def image?
    true
  end

end
