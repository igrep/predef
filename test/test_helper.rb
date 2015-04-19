if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

def example description, &block
  puts '--------------------------------------------------------------------------------'.freeze
  puts "-- #{description}"
  puts '--------------------------------------------------------------------------------'.freeze
  block.call
  puts
end

def test description, boolean_expression, on_failure
  puts description
  if boolean_expression
    puts 'OK'.freeze
  else
    fail "Assertion failed.\n#{on_failure}"
  end
end
