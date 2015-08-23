require 'minitest_helper'

class TestWrapsMethods < ForewarnTest
  class FakeWarner
    def methods
      [Kernel.method(:method)]
    end
  end

  def setup
    @builds_method_values = gimme_next(Forewarn::BuildsMethodValues)
    @remembers_wrapped_methods = gimme_next(Forewarn::RemembersWrappedMethods)
    @overrides_methods = gimme_next(Forewarn::OverridesMethods)

    @subject = Forewarn::SetsUpWarnings.new
  end

  def test_collaboration
    Forewarn.config[:warners] = [FakeWarner]
    method_values = [Forewarn::Values::Method.new]
    give(@builds_method_values).build(is_a(FakeWarner)) { method_values }

    @subject.set_up!

    verify(@overrides_methods).override!(method_values)
    verify(@remembers_wrapped_methods).remember!(method_values)
  end
end
