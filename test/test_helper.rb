if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

def example description, &block
  puts "- #{description}"
  block.call
  puts
end

def note content
  puts "-- # #{content}"
end

def test boolean_expression, on_failure
  if boolean_expression
    puts '=> OK'.freeze
  else
    fail "Assertion failed.\n\n    ==> #{on_failure}\n\n"
  end
end
