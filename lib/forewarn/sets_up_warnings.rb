module Forewarn
  class SetsUpWarnings
    def initialize(collects_warners, builds_method_values,
                   remembers_wrapped_methods, overrides_methods)
      @collects_warners = collects_warners
      @builds_method_values = builds_method_values
      @remembers_wrapped_methods = remembers_wrapped_methods
      @overrides_methods = overrides_methods
    end

    def wrap!
      methods = @collects_warners.collect
        .map {|w| @builds_method_values.build(w) }.flatten
      @overrides_methods.override!(methods)
      @remembers_wrapped_methods.remember!(methods)
    end
  end
end
