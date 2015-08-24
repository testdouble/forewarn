require "minitest_helper"

class TestTriggersWarning < ForewarnTest
  def fake_warn(string)
    @last_warning = string
  end

  class Turtle
    def swim
    end
  end

  class BasicWarner
    def message
      "Aquatic turtle method"
    end
  end

  def setup
    @subject = Forewarn::TriggersWarning.new
  end

  def test_logging
    Forewarn.config(:logger => method(:fake_warn))
    method = Forewarn::Values::Method.new(BasicWarner.new, Turtle.instance_method(:swim))

    @subject.trigger!(method, "foo/bar/baz.rb:1337 in 'lolol'")

    assert_equal @last_warning, "WARN: Aquatic turtle method 'TestTriggersWarning::Turtle#swim' was invoked! (Called from: \"foo/bar/baz.rb:1337 in 'lolol'\")"
  end
end
