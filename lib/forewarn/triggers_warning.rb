module Forewarn
  class TriggersWarning
    def trigger!(method)
      Forewarn.config[:logger].call(build_warning(method))
    end

  private

    def build_warning(method)
      "WARN: #{method.warner.message} #{method.name} was invoked! #{method.source_location}"
    end
  end
end

