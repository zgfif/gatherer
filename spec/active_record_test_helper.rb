require 'spec_helper'
require 'active_record'
require_relative '../app/models/application_record'

require_relative '../app/models/concerns/sizeable'
require_relative '../app/models/task'
require_relative '../app/models/project'
require 'factory_bot_rails'
require_relative 'support/size_matcher.rb'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/test.sqlite3'
)

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end

FactoryBot.find_definitions

Time.zone = 'Kyiv'
