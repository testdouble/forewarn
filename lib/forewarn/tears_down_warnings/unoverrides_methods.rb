module Forewarn
  class TearsDownWarnings
    class UnoverridesMethods
      def unoverride!(methods)
        methods.each do |method|
          real_method = method.method
          real_method.owner.send(:define_method,
                                 real_method.name,
                                 real_method.respond_to?(:unbind) ? real_method.unbind : real_method)
        end
      end
    end
  end
end
