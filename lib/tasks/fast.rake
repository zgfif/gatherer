require 'rake/testtask'

# Rake::TestTask.new(:fast) do |t|
#   t.pattern = 'test/{models,actions,values}/**/project_test.rb'
# end
#
task :fast_tests do
  Dir.glob("test/{models,actions,values}/**/project_test.rb").each { |file| require_relative "../../#{file}" }
end
