require 'minitest/autorun'
require 'mocha/minitest'
require 'active_support/test_case'
require 'active_record'
require 'minitest/reporters'
require 'factory_bot_rails'
require 'database_cleaner'
require_relative '../app/models/application_record'
require_relative '../app/models/concerns/sizeable'
require_relative '../app/models/task'
require_relative '../app/models/project'

FactoryBot.find_definitions

reporter_options = { color: true }
Minitest::Reporters.use!([Minitest::Reporters::DefaultReporter.new(reporter_options)])

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/test.sqlite3')

DatabaseCleaner.strategy = :truncation

module ActiveSupport
  class TestCase
    teardown do
      DatabaseCleaner.clean
    end
  end
end
