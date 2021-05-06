# Forewarn
[![Build Status](https://travis-ci.org/testdouble/forewarn.svg)](https://travis-ci.org/testdouble/forewarn)

## What

Forewarn gives you an API for logging warnings whenever a method is invoked that
you consider as deprecated, dangerous, or otherwise undesirable. By default, it
will only log warnings when mutative methods on `String` are invoked, but users
can easily register their own "warner" objects with the gem.

## Setup

### Install

Getting started (recommend you use this in development or test, as it has the
potential to wrap some very high-traffic methods and negatively impact
performance):

``` ruby
gem 'forewarn', :group => [:development, :test]
```

### Basic use

This [simple listing](https://github.com/testdouble/forewarn/blob/main/docs/driver.rb) demonstrates basic usage:

``` ruby
require 'forewarn'

foo = "foo"

Forewarn.start!

foo << "UH OH"

puts "YEAH #{foo}"
```

When executed, the code above will output the following, indicating it is
logging a warning without impacting the normal behavior of `String#<<`:

```
$ ruby docs/driver.rb
WARN: String mutation method 'String#<<' was invoked! (Called from: "docs/driver.rb:6:in `<main>'")
YEAH fooUH OH
```

### Writing a Warner

To write your own warner object, you just need a class with instance methods of
`message` and `methods`. The implementation of built-in [StringMutation](https://github.com/testdouble/forewarn/blob/main/lib/forewarn/warners/string_mutation.rb)
should be a good example.

To register your warner, just set or mutate the `warners` config property:

``` ruby
Forewarn.config[:warners] << MyCustomWarnerClass # <- add my warner

Forewarn.config[:warners] = [MyCustomWarnerClass] # <- replace all warners
```

### Setting a different logger method

Since the `warn` method can get pretty chatty over STDOUT, you can redirect it
however you like by setting a custom logger method:

``` ruby
class LogsWarnings
  attr_reader :warnings
  def warn(warning)
    @warnings ||= []
    @warnings << warning
  end
end
logger = LogsWarnings.new

Forewarn.config(:logger => logger.method(:warn))
```

The above will invoke `warn` on the provided instance of `LogsWarning` and take
no other action (e.g. won't print to STDOUT or STDERR).

## Background

Forewarn was inspired by this [Twitter thread](https://twitter.com/wycats/status/634538646402674688) about the proposed Ruby 3 behavior,
which would freeze all String literals by default unless a magic comment
appeared in the source listing.

What @wycats did was raise the very practical issue that this could create
a Python 3-esque compatibility rift, as any gems which casually make use of
String-mutating methods (e.g. `gsub!`) will raise errors under Ruby 3, and the
end user won't be very well equipped to respond (since it's not practical to
cycle through your installed gems and sprinkle in magic comments everywhere).

As a curiosity, I wondered "would it be practical to demonstrate how widespread
a problem this might be in advance?" This gem attempts to do that by logging
warnings whenever anyone invoked a method that would raise an error if it were
invoked on a frozen string.
