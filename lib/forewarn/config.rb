require "forewarn/reporters/json"

module Forewarn
  DEFAULT_CONFIG = {
    :enabled => true,
    :logger => Kernel.method(:warn),
    :reporter => Forewarn::Reporters::Json,
    :report_destination => "log/usage_warning.json"
  }.freeze

  @__config = DEFAULT_CONFIG.dup

  def self.config(overrides = {})
    @__config.merge!(overrides)
  end
end

