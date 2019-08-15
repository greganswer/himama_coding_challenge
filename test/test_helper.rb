ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  
  # NOTE: Uncomment the line below if FactoryBot cannot find factories
  # FactoryBot.find_definitions
end
