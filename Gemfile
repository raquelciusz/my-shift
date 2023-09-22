source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Gems for all environments
gem "rails", "~> 7.0.4"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "bootsnap", require: false
gem "money-rails"
gem "stripe"
gem "sassc-rails"
gem "devise"
gem "autoprefixer-rails"
gem "font-awesome-sass", "~> 6.1"
gem "simple_form", github: "heartcombo/simple_form"
gem "cloudinary"
gem "pundit"
gem "file_validators"
gem "simple_calendar", "~> 2.4"
gem "letter_opener", group: :development

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "web-console"
  # Add any other development and test gems here
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
group :production do
  gem 'cloudinary'
  # Other production gems...
end
