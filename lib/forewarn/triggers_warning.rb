module Forewarn
  class TriggersWarning
    def trigger!(method, kaller)
      return if backtrace_includes_ourself?
      Forewarn.config[:logger].call(build_warning(method, kaller))
    end

  private

    # Need to bail out to prevent infinite recursion… Woo!
    def backtrace_includes_ourself?
      caller_locations.select { |location|
        location.to_s.include?(File.join(%w{forewarn lib forewarn triggers_warning}))
      }.size > 1
    end

    def build_warning(method, kaller)
      "WARN: #{method.warner.message} '#{method.name}' was invoked! (Called from: \"#{kaller}\")"
    end
  end
end

