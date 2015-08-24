require "minitest_helper"

class TestMethod < ForewarnTest
  class Dog
    attr_reader :barks
    def initialize
      @barks = 0
    end
    def bark
      @barks += 1
    end

    def self.yelp
      :woof
    end
  end

  def test_warner_is_retained
    assert_equal :blah_warner, new_method(:blah_warner, nil).warner
  end

  def test_instance_method_checker
    assert new_method(nil, Dog.instance_method(:bark)).instance_method?
    assert new_method(nil, Dog.new.method(:bark)).instance_method?
    assert !new_method(nil, Dog.method(:yelp)).instance_method?
  end

  def test_method_names
    assert_equal "TestMethod::Dog.yelp", new_method(nil, Dog.method(:yelp)).name
    assert_equal "TestMethod::Dog#bark", new_method(nil, Dog.instance_method(:bark)).name
    assert_equal "TestMethod::Dog#bark", new_method(nil, Dog.new.method(:bark)).name
  end

  def test_bind_will_bind_to_the_right_instance
    dog1 = Dog.new
    dog2 = Dog.new

    new_method(nil, dog1.method(:bark)).bind(dog2).call

    assert_equal 1, dog2.barks
    assert_equal 0, dog1.barks
  end

  def test_bind_will_work_if_instance_method_is_unbound_to_begin_with
    dog = Dog.new

    new_method(nil, Dog.instance_method(:bark)).bind(dog).call

    assert_equal 1, dog.barks
  end

  def test_bind_does_not_screw_up_class_methods
    assert_equal :woof, new_method(nil, Dog.method(:yelp)).bind(Dog).call
    assert_equal :woof, new_method(nil, Dog.method(:yelp).unbind).bind(Dog).call
  end

  def test_source_location_when_its_known
    faux_method = gimme(Method)
    give(faux_method).respond_to?(:source_location) { true }
    give(faux_method).source_location { ["some_file.rb", 12] }
    method = new_method(nil, faux_method)

    assert_equal "Source at: 'some_file.rb:12'", method.source_location
  end

  def test_source_location_when_its_a_c_method
    method = new_method(nil, String.instance_method(:gsub!))

    assert_equal "Source location unknown", method.source_location
  end
private

  def new_method(warner, method)
    Forewarn::Values::Method.new(warner, method)
  end
end
