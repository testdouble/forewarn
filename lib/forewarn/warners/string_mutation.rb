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
        String.instance_methods.select { |method_name|
          method_name.to_s.end_with?('!')
        } + [
          :"[]=", :"<<", :clear, :concat, :extend, :insert,
          :instance_variable_set, :prepend, :replace, :setbyte, :taint
        ] - [
          :"!" # <-- lol BasicObject#! is A-okay.
        ]
      end
    end
  end
end
