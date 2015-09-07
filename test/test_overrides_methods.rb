require "minitest_helper"

class TestOverridesMethods < ForewarnTest
  def setup
    @triggers_warning = gimme_next(Forewarn::TriggersWarning)
    @subject = Forewarn::OverridesMethods.new
  end

  class Animal
    def make_noise
      :yelp
    end
  end

  class Cat < Animal
    def meow
    end
  end

  def test_trigger
    method = Forewarn::Values::Method.new(nil, Cat.new.method(:make_noise))

    @subject.override!([method])
    Cat.new.make_noise
    called_from = __LINE__ - 1

    verify(@triggers_warning).trigger!(method, regex(/.*forewarn\/test\/test_overrides_methods.rb:#{called_from}:in `#{__method__}'/))
  end

  def test_skip_trigger_on_broader_receiver_type
    method = Forewarn::Values::Method.new(nil, Cat.new.method(:make_noise))

    @subject.override!([method])
    result = Animal.new.make_noise

    assert_equal :yelp, result
    verify(@triggers_warning, 0).trigger!
  end
end
