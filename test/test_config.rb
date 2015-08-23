require 'minitest_helper'

class TestConfig < Minitest::Test
  def setup
    Forewarn.config(Forewarn::DEFAULT_CONFIG)
  end

  def test_defaults
    assert_equal Forewarn::DEFAULT_CONFIG, Forewarn.config
    assert Forewarn::DEFAULT_CONFIG.frozen?
  end

  def test_overwrite_an_option
    result = Forewarn.config(:enabled => false)

    assert_equal Forewarn::DEFAULT_CONFIG.merge(:enabled => false), result
    assert_equal Forewarn.config, result, "change is persisted"
    assert_equal Forewarn::DEFAULT_CONFIG[:enabled], true, "default is same"
  end
end
