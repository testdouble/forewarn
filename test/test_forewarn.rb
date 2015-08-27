require 'minitest_helper'

class TestForewarn
  class Isolation < ForewarnTest
    def test_that_it_has_a_version_number
      refute_nil ::Forewarn::VERSION
    end

    def test_start_sets_up_warnings
      sets_up_warnings = gimme_next(Forewarn::SetsUpWarnings)

      Forewarn.start!

      verify(sets_up_warnings).set_up!
    end
  end

  class Integration < ForewarnTest
    def fake_warning(warning)
      @warnings << warning
    end

    def setup
      @warnings = []
      Forewarn.config(:logger => method(:fake_warning))
    end

    def test_integrated_thing_works
      String some_string = "WOOO"

      Forewarn.start!
      some_string << "P"

      assert_equal "WOOOP", some_string
      assert_match /WARN: String mutation method 'String#<<' was invoked! \(Called from: \".*forewarn\/test\/test_forewarn.rb:\d+:in `test_integrated_thing_works'\"\)/, @warnings.first
    end

    def test_integrated_doesnt_broaden_beyond_receiver_types
      thing = Object.new

      Forewarn.start!
      thing.taint

      assert_empty @warnings
    end
  end
end
