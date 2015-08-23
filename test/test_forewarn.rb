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
end
