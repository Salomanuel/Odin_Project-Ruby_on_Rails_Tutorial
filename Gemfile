source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails',            '5.0.1'
gem 'bcrypt',           '3.1.11'  # for has_secure
gem 'faker',            '1.7.3'   # Hipster generator
gem 'will_paginate',    '3.1.5'   # for paginating
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap-sass',   '3.3.6'
gem 'puma',             '3.11.2'     # for the server, was '3.0'
gem 'sass-rails',       '5.0.6'   # css enhanced
gem 'uglifier',         '3.0.0'     # JS parser
gem 'coffee-rails',     '4.2.1'     # Coffee Script (enhanced JS)
gem 'jquery-rails',     '4.1.1'     # JQuery
gem 'turbolinks',       '5.0.1'
gem 'jbuilder',         '2.4.1'
gem 'pg' # for the damn heroku
gem 'carrierwave',      '1.1.0' # image uploader
gem 'mini_magick',      '4.7.0' # image resizing
gem 'fog',              '1.40.0'# image upload in production

group :development, :test do
  gem 'sqlite3',        '1.3.12'
  gem 'byebug',         '9.0.0', platform: :mri
end

group :development do
  gem 'web-console',    '3.1.1'
  gem 'listen',         '3.0.8'
  gem 'spring',         '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
  gem 'pry-rails'
end

group :test do
  gem 'minitest',                 '~> 5.10', '!= 5.10.2'
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters',       '1.1.9'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
