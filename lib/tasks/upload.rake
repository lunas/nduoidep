require 'dotenv/tasks'
require 'uploader'

namespace :nguoidep do

  desc 'Upload images from the PAGE_IMAGE_DIR to aws and create the correpsonding pages on NGUOIDEP_SERVER'
  task :upload => [:environment, :dotenv] do
    image_dir     = ENV['PAGE_IMAGE_DIR'] || '/page_images'
    image_pattern = ENV['PAGE_IMAGE_PATTERN'] || '*.jpg'
    server        = ENV['NGUOIDEP_SERVER'] || 'http://www.nguoidepmagazine-ny.com'

    image_dir = Rails.root.to_s + image_dir

    puts "Going to upload pictures matching file name '#{image_pattern}'"
    puts "  from folder #{image_dir} to AWS"
    puts "  and to create corresponding pages on #{server}."
    uploader = Uploader.new(image_dir, image_pattern, server)
    uploader.run
    uploader.show_results
  end

end