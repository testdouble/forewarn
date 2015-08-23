require "forewarn/reporters/json"

module Forewarn
  DEFAULT_CONFIG = {
    :enabled => true,
    :logger => Kernel.method(:warn),
    :reporter => Forewarn::Reporters::Json,
    :report_destination => "log/usage_warning.json"
  }
  @__config = DEFAULT_CONFIG.clone

  def self.config(overrides = {})
    @__config.merge!(overrides)
  end
end

