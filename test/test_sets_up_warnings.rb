require 'minitest_helper'

module Forewarn
  class CollectsWarners
    def collect(warners)
    end
  end
end

module Forewarn
  class BuildsMethodValues
    def build(methods)
    end
  end
end

module Forewarn
  class RemembersWrappedMethods
    def remember!(methods)
    end
  end
end

module Forewarn
  class OverridesMethods
    def override!(methods)
    end
  end
end

module Forewarn
  module Values
    class Method
    end
  end
end

class TestWrapsMethods < Minitest::Test
  class FakeWarner
    def methods
      [Kernel.method(:method)]
    end
  end

  def setup
    @subject = Forewarn::SetsUpWarnings.new(
      @collects_warners = gimme(Forewarn::CollectsWarners),
      @builds_method_values = gimme(Forewarn::BuildsMethodValues),
      @remembers_wrapped_methods = gimme(Forewarn::RemembersWrappedMethods),
      @overrides_methods = gimme(Forewarn::OverridesMethods)
    )
  end

  def test_collaboration
    warners = [FakeWarner.new]
    give(@collects_warners).collect { warners }
    method_values = [Forewarn::Values::Method.new]
    give(@builds_method_values).build(warners.first) { method_values }

    @subject.wrap!

    verify(@overrides_methods).override!(method_values)
    verify(@remembers_wrapped_methods).remember!(method_values)
  end
end
