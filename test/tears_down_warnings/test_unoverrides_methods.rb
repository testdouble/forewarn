require "minitest_helper"

module Forewarn
  class TearsDownWarnings
    class TestUnoverridesMethods < ForewarnTest
      class Cat
        def meow
        end
      end

      def setup
        @subject = UnoverridesMethods.new
      end

      def test_it_restores_the_method
        method = Forewarn::Values::Method.new(nil, Cat.instance_method(:meow))
        Cat.send(:define_method, :meow) do |*args, &blk|
          raise "if unoverride! worked this won't raise"
        end

        @subject.unoverride!([method])

        Cat.new.meow
      end

      def test_that_it_is_a_noop_if_its_not_overridden
        skip "pending"
      end

    end
  end
end
