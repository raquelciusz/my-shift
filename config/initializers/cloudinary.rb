# config/initializers/cloudinary.rb
Cloudinary.config do |config|
  config.cloud_name = 'your_cloud_name'
  config.api_key = 'your_api_key'
  config.api_secret = 'your_api_secret'
  config.secure = true # Use HTTPS
end
