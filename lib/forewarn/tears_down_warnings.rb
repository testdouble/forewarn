require "forewarn/remembers_wrapped_methods"
require_relative "tears_down_warnings/unoverrides_methods"

module Forewarn
  class TearsDownWarnings
    def initialize
      @remembers_wrapped_methods = RemembersWrappedMethods.new
      @unoverrides_methods = TearsDownWarnings::UnoverridesMethods.new
    end

    def tear_down!
      @unoverrides_methods.unoverride!(
        @remembers_wrapped_methods.remembered_methods
      )
    end
  end
end
