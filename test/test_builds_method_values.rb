require "minitest_helper"

class TestBuildsMethodValues < ForewarnTest
  class Dog
    def bark
    end
  end
  class DogWarner
    def methods
      [
        Dog.instance_method(:bark)
      ]
    end
  end

  def setup
    @subject = Forewarn::BuildsMethodValues.new
  end

  def test_simple_case
    warner = DogWarner.new

    method_value, *others = @subject.build(warner)

    assert_equal warner, method_value.warner
    assert_equal Dog.instance_method(:bark), method_value.method
    assert_equal 0, others.size
  end
end
