require "minitest_helper"

class TestOverridesMethods < ForewarnTest
  def setup
    @triggers_warning = gimme_next(Forewarn::TriggersWarning)

    @subject = Forewarn::OverridesMethods.new
  end

  class Cat
    def meow
    end
  end

  def test_trigger
    method = Forewarn::Values::Method.new(nil, Cat.instance_method(:meow))

    @subject.override!([method])
    Cat.new.meow

    verify(@triggers_warning).trigger!(method, regex(/.*forewarn\/test\/test_overrides_methods.rb:19:in `test_trigger'/))
  end
end
