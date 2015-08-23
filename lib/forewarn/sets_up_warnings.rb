module Forewarn
  class SetsUpWarnings
    def initialize(builds_method_values,
                   remembers_wrapped_methods, overrides_methods)
      @builds_method_values = builds_method_values
      @remembers_wrapped_methods = remembers_wrapped_methods
      @overrides_methods = overrides_methods
    end

    def wrap!
      methods = Forewarn.config[:warners].map(&:new).map {|w| @builds_method_values.build(w) }.flatten
      @overrides_methods.override!(methods)
      @remembers_wrapped_methods.remember!(methods)
    end
  end
end
