CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
  	provider:              'AWS',                        
    aws_access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),                        
    aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),                       
    use_iam_profile:       false,                         # optional, defaults to false
    region:                ENV.fetch('AWS_REGION'), 
  }
  config.fog_directory = ENV.fetch('S3_BUCKET_NAME')
  config.fog_public   = false
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end
  
