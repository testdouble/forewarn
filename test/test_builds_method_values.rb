require "minitest_helper"

class TestBuildsMethodValues < ForewarnTest
  class Dog
    def bark
    end
  end

  def setup
    @subject = Forewarn::BuildsMethodValues.new
  end

  class GoodDogWarner
    def methods
      [ Dog.new.method(:bark) ]
    end
  end
  def test_good_warner

    warner = GoodDogWarner.new

    method_value, *others = @subject.build(warner)

    assert_equal warner, method_value.warner
    assert_equal Dog.instance_method(:bark), method_value.method.unbind
    assert_equal 0, others.size
  end

  class UnboundDogWarner
    def methods
      [ Dog.instance_method(:bark) ]
    end
  end
  def test_rejects_unbound_methods
    warner = UnboundDogWarner.new

    err = assert_raises(Forewarn::UnboundMethodError) { @subject.build(warner) }
    assert_equal "Forewarn only supports warnings for methods bound to a receiver (e.g. \"foo\".method(:gsub!) but not String.instance_method(:gsub!)), due to limitations in Ruby's UnboundMethod API", err.message
  end
end
