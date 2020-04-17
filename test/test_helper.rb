require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    fixtures :all
    # Add more helper methods to be used by all tests here...
  end
end

def assert_select_string(string, *selectors, &block)
  doc_root = Nokogiri::HTML::Document.parse(string).root
  assert_select(doc_root, *selectors, &block)
end
