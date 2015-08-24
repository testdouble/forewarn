require 'minitest_helper'

class TestForewarn < ForewarnTest
  def test_that_it_has_a_version_number
    refute_nil ::Forewarn::VERSION
  end

  def test_start_sets_up_warnings
    sets_up_warnings = gimme_next(Forewarn::SetsUpWarnings)

    Forewarn.start!

    verify(sets_up_warnings).set_up!
  end

  def fake_warning(warning)
    @warnings ||= []
    @warnings << warning
  end
  def test_integrated_thing_works
    Forewarn.config(:logger => method(:fake_warning))

    String some_string = "WOOO"

    Forewarn.start!

    some_string << "P"
    assert_equal "WOOOP", some_string
    assert_match /WARN: String mutation method 'String#<<' was invoked! \(Called from: \".*forewarn\/test\/test_forewarn.rb:27:in `test_integrated_thing_works'\"\)/, @warnings.first
  end
end
