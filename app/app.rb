require 'active_support/all'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'securerandom'
require './config/settings'

%w[models apis lib].each do |directory|
  Dir[File.join(__dir__, directory, '*.rb')].each { |file| require file }
end
