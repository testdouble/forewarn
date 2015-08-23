require "forewarn/reporters/json"
require "forewarn/warners/string_mutation"

module Forewarn
  DEFAULT_CONFIG = {
    :enabled => true,
    :logger => Kernel.method(:warn),
    :reporter => Forewarn::Reporters::Json,
    :report_destination => "log/usage_warning.json",
    :warners => [Forewarn::Warners::StringMutation]
  }.freeze

  @__config = DEFAULT_CONFIG.dup

  def self.config(overrides = {})
    @__config.merge!(overrides)
  end
end

