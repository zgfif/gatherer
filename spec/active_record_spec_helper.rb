require_relative '../app/models/application_record'
require_relative '../app/models/concerns/sizeable'
require_relative '../app/models/project'
require_relative '../app/models/task'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/test.sqlite3')

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
