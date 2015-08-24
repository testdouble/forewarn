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
end
