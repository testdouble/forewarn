module Forewarn
  module Values
    class Method
      attr_reader :warner, :method

      def initialize(warner = nil, method = nil)
        @warner = warner
        @method = method
      end

      # It's a pain to try to suss this out by
      # The method's owner (Dog vs Class:Dog) classes, etc
      # but Method#inspect's C implementation makes finding
      # instance-y-ness pretty straightforward by using the # vs .
      # separator for the method
      def instance_method?
        @method.to_s =~ /<.*#/
      end

      def name
        @method.to_s[/:\s*(.*)>/, 1]
      end

      def bind(new_owner)
        if @method.respond_to?(:unbind)
          @method.unbind.bind(new_owner)
        else
          @method.bind(new_owner)
        end
      end

    end
  end
end

