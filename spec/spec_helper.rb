require 'simplecov'
SimpleCov.start
require './lib/recipe'
require './lib/feedback'
require './lib/user'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }
