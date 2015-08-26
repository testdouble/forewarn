require "minitest_helper"

module Forewarn
  class TestRemembersWrappedMethods < ForewarnTest
    def setup
      @subject = RemembersWrappedMethods.new
    end

    def test_remember_methods_and_forget_methods
      methods = [Values::Method.new]

      @subject.remember!(methods)
      result = @subject.remembered_methods

      assert_equal 1, result.size
      assert_equal methods.first, result.first

      @subject.forget!
      result = @subject.remembered_methods

      assert_equal 0, result.size
    end


  end
end
