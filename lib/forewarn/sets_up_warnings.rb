require "forewarn/builds_method_values"
require "forewarn/remembers_wrapped_methods"
require "forewarn/overrides_methods"

module Forewarn
  class SetsUpWarnings
    def initialize(builds_method_values = BuildsMethodValues.new,
                   remembers_wrapped_methods = RemembersWrappedMethods.new,
                   overrides_methods = OverridesMethods.new)
      @builds_method_values = builds_method_values
      @remembers_wrapped_methods = remembers_wrapped_methods
      @overrides_methods = overrides_methods
    end

    def set_up!
      methods = Forewarn.config[:warners].map(&:new).map {|w| @builds_method_values.build(w) }.flatten
      @overrides_methods.override!(methods)
      @remembers_wrapped_methods.remember!(methods)
    end
  end
end
