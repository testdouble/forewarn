require 'forewarn'

class LogsWarnings
  attr_reader :warnings
  def warn(warning)
    @warnings ||= []
    @warnings << warning
  end
end
logger = LogsWarnings.new

Forewarn.config(:logger => logger.method(:warn))
Forewarn.start!

foo = "foo"
foo << "UH OH"

puts "YESSSSS #{logger.warnings}"

