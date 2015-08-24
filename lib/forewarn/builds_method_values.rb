require "forewarn/values/method"

module Forewarn
  class BuildsMethodValues
    def build(warner)
      warner.methods.map do |method_object|
        Values::Method.new(warner, method_object)
      end
    end
  end
end
