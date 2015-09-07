require 'minitest_helper'

class TestConfig < ForewarnTest
  def test_defaults_are_frozen
    assert_predicate Forewarn::DEFAULT_CONFIG, :frozen?
  end

  def test_overwriting_an_option_persists_the_change
    keys       = Forewarn.config.keys
    initial    = Forewarn.config[:enabled]
    overridden = !initial

    begin
      Forewarn.config(:enabled => overridden)
      assert_equal Forewarn.config[:enabled], overridden
      assert_equal Forewarn.config.keys, keys
    ensure
      Forewarn.config(:enabled => initial)
    end
  end
end
