require "bundler/setup"
require "sinatra/activerecord"
Bundler.require
require_all 'app/models'

ENV['SINATRA_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)
