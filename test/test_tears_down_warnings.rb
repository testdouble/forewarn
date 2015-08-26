require "minitest_helper"

module Forewarn
  class TestTearsDownWarnings < ForewarnTest
    def setup
      @remembers_wrapped_methods = gimme_next(RemembersWrappedMethods)
      @unoverrides_methods = gimme_next(TearsDownWarnings::UnoverridesMethods)

      @subject = TearsDownWarnings.new
    end

    def test_tear_down
      methods = []
      give(@remembers_wrapped_methods).remembered_methods { methods }

      @subject.tear_down!

      verify(@unoverrides_methods).unoverride!(methods)
      verify(@remembers_wrapped_methods).forget!
    end
  end
end
