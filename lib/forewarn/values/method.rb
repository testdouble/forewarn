module Forewarn
  module Values
    class Method
      attr_reader :warner, :method

      def initialize(warner = nil, method = nil)
        @warner = warner
        @method = method
      end

      def instance_method?
        !@method.owner.singleton_class?
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

