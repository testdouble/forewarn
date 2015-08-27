module Forewarn
  class UnboundMethodError < StandardError
    def to_s
      "Forewarn only supports warnings for methods bound to a receiver (e.g. \"foo\".method(:gsub!) but not String.instance_method(:gsub!)), due to limitations in Ruby's UnboundMethod API"
    end
  end
end
