Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUD_NAME_CLOUDINARY']
  config.api_key = ENV['API_KEY_CLOUDINARY']
  config.api_secret = ENV['API_SECRET_CLOUDINARY']
  config.secure = true
  config.cdn_subdomain = true
end