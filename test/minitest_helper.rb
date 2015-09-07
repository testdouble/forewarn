$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'forewarn'

require 'minitest/autorun'

require 'gimme'
require 'pry'

class ForewarnTest < Minitest::Test
  def forewarn_logger
    @logger ||= ForewarnLogger.new
  end

  def forewarn_test_config
    { enabled: true,
      logger:  forewarn_logger,
      warners: [],
    }
  end

  def after_teardown
    Gimme.reset
    Forewarn.config(forewarn_test_config)
  end

  def regex(regex_input)
    RegexMatcher.new(regex_input)
  end
end

class ForewarnLogger
  def call(*args)
    logged << args
  end

  def logged
    @logged ||= []
  end
end

class RegexMatcher
  def initialize(regex_input)
    @regex_input = regex_input
  end

  def matches?(arg)
    arg =~ @regex_input
  end
end
