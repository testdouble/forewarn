module Forewarn
  class SetsUpWarnings
    def initialize(collects_warners, builds_method_values,
                   remembers_wrapped_methods, overrides_methods)
      @collects_warners = collects_warners
      @builds_method_values = builds_method_values
      @remembers_wrapped_methods = remembers_wrapped_methods
      @overrides_methods = overrides_methods
    end
  end
end
