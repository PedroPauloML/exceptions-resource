# Exceptions

This small lib will play with many kinds of exceptions and return then as json with all needed informations to build awesome errors responses
needs `ActiveModel` as dependency if you aren't working with rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exceptions', github: 'xdougx/exceptions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exceptions

## Usage

Its simple to use for a model

``` ruby
redaction = Redaction.new
redaction.valid?
exception = Exceptions::Model.build(redaction)
ap exception.error # awesome print to help us
```

### Result
``` json
{
  "error": {
    "model": "Redaction",
    "field": "redaction[subject]",
    "attribute": "subject",
    "message": "can't be blank",
    "full_message": "Subject can't be blank"
  }
}
```

If you need to build a exception just with a message

``` ruby
exception = Exceptions::Simple.build(field: "Name", message: "is needed to be filled")
ap exception.error
```

### Result
``` json
{
  "error": {
    "message": "is needed to be filled",
    "full_message": "Name is needed to be filled",
    "field": "Name"
  }
}
```

Need an application exception?

``` ruby
exception = Exceptions::UnauthorizedApplication.build(message: "You have no permission to access this API")
ap exception.error
```

### Result
``` json
{
  "error": {
    "message": "You have no permission to access this API"
  }
}
```

### Build your exception

``` ruby
class Exceptions::MyAppException

  def error
    { 
      error: { 
        error_code: self.error_code, 
        message: self.message,
      } 
    }
  end

  def message 
    self.object.message
  end

  def error_code
    if self.object.error_code
  end

  def status
    :unprocessable_entity
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/exceptions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
