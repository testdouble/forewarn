$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'forewarn'

require 'minitest/autorun'

require 'gimme'
require 'pry'

class ForewarnTest < Minitest::Test
  def after_teardown
    Gimme.reset
    Forewarn.config(Forewarn::DEFAULT_CONFIG)
  end

  def regex(regex_input)
    RegexMatcher.new(regex_input)
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
