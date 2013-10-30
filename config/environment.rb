require "bundler/setup"

require 'active_record'

Bundler.require

require_relative '../app/models/network.rb'
require_relative '../app/models/show.rb'
require_relative '../app/models/character.rb'

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
