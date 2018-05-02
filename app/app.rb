require 'active_support/all'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'i18n'
require 'i18n/backend/fallbacks'
require 'securerandom'
require File.expand_path '../config/settings', __FILE__

%w[models apis lib].each do |directory|
  Dir[File.join(__dir__, directory, '*.rb')].each do |file|
    require File.expand_path file, __FILE__
  end
end
