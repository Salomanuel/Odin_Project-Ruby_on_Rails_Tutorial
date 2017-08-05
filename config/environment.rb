# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# because all the test go crazy after putting Carrierwave
require 'carrierwave'
require 'carrierwave/orm/activerecord'
