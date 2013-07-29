# encoding: utf-8
require 'carrierwave/processing/rmagick'

class PageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  attr_accessor :page_id

  process :resize_to_fit => [1040, 2000]  # 2000: big enough in any case
  process :quality => 70

  def store_dir
    raise 'page_id not set' if @page_id.nil?
    "uploads/page/image/#{@page_id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def image?
    true
  end

end
