module Forewarn
  module Warners
    class StringMutation
      def message
        "String mutation method"
      end

      def methods
        method_names.map { |m| String.instance_method(m) }
      end

    private

      def method_names
        String.instance_methods.select {|m|
          m.to_s.end_with?('!')
        } + [:"[]=", :"<<", :concat, :insert, :replace, :setbyte, :taint]
      end
    end
  end
end
