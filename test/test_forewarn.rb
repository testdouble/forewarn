require 'minitest_helper'

class TestForewarn < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Forewarn::VERSION
  end
end
