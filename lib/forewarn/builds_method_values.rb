require "forewarn/values/method"
require "forewarn/unbound_method_error"

module Forewarn
  class BuildsMethodValues
    def build(warner)
      warner.methods.map do |method_object|
        raise UnboundMethodError.new if method_object.respond_to?(:bind)
        Values::Method.new(warner, method_object)
      end
    end
  end
end
