# Predef

Shortcut for prepend-ing Module. Maybe useful for debugging.

[![Build Status](https://travis-ci.org/igrep/predef.svg?branch=master)](https://travis-ci.org/igrep/predef)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'predef'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install predef

## Usage

### Example: Collect All Queries Executed in a Test

Given you're using some third-party database client library like this...

```ruby
class HogeSQL::Connection
  def execute query
    # ...
  end

  # ...
end
```

Imagine you want to see all `SELECT` queries and the stacktrace when executed, without any change of `HogeSQL::Connection`.

```ruby
require 'predef'

Predef.predef HogeSQL::Connection, :execute do|query|
  if query.include? 'SELECT'
    puts query
    pp caller
  end
  super # call the original query method.
end

# ... your app or some test code ...
```

Then you'd get...

```ruby
SELECT * from your_apps_table WHERE ...
["/path/to/your_app/app/models/foo.rb:355:in `some_method_in_model'",
 "/path/to/your_app/app/controllers/foo_controller.rb:355:in `some_action_in_controller'",
 ...]

...
```

This is just a shortcut for:

```ruby
module SomeWrapper
  def execute
    if query.include? 'SELECT'
      puts query
      pp caller
    end
    super # call the original execute method.
  end
end

HogeSQL::Connection.__send__(:prepend, SomeWrapper)
```

So you can more quickly inspect code you don't want to change directly!

### More Ruby-ish Way

Or would you like `using` this way?
Though it's a bit more verbose to prepend only one method.

```ruby
using Predef::Refinements

HogeSQL::Connection.predef :execute do|query|
  # same here with the last example...
end
```

## For more methods:

See and/or execute [test/example.rb](test/example.rb):

```bash
$ git clone git@github.com:igrep/predef.git
$ cd predef
$ bundle
$ bundle exec ruby test/example.rb
```

## Contributing

1. Fork it ( https://github.com/igrep/predef/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
