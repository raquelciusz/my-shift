# config/initializers/cloudinary.rb
Cloudinary.config do |config|
  config.cloud_name = CLOUDINARY_CLOUD_NAME
  config.api_key = CLOUDINARY_API_KEY
  config.api_secret = CLOUDINARY_API_SECRET
  config.secure = true # Use HTTPS
end
