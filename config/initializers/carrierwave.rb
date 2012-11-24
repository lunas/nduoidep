if Rails.env.test? or Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = true
  end
else
  CarrierWave.configure do |config|
    raise "Make sure you put your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY into your environment." if ENV["AWS_ACCESS_KEY_ID"].nil? or ENV["AWS_SECRET_ACCESS_KEY"].nil?
    config.storage = :fog
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
        :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY']
        # :region                 => 'us-west-1' #should probably be standard
    }
    config.fog_directory  = 'nguoidep'
    config.asset_host = "http://#{config.fog_directory}.s3.amazonaws.com" # make carrierwave not use SSL
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
  end
end