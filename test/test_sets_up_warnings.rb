require 'minitest_helper'

class TestWrapsMethods < Minitest::Test
  class FakeWarner
    def methods
      [Kernel.method(:method)]
    end
  end

  def setup
    @subject = Forewarn::SetsUpWarnings.new(
      @builds_method_values = gimme(Forewarn::BuildsMethodValues),
      @remembers_wrapped_methods = gimme(Forewarn::RemembersWrappedMethods),
      @overrides_methods = gimme(Forewarn::OverridesMethods)
    )
  end

  def test_collaboration
    Forewarn.config[:warners] = [FakeWarner]
    method_values = [Forewarn::Values::Method.new]
    give(@builds_method_values).build(is_a(FakeWarner)) { method_values }

    @subject.wrap!

    verify(@overrides_methods).override!(method_values)
    verify(@remembers_wrapped_methods).remember!(method_values)
  end
end
