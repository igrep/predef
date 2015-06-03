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

def error_of &block
  block.call
rescue ::Exception => e
  return e
else
  return nil
end
