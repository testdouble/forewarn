require "forewarn/reporters/json"
require "forewarn/warners/string_mutation"

module Forewarn
  DEFAULT_CONFIG = {
    :enabled => true,
    :logger => Kernel.method(:warn),
# TODO: implement a JSON reporter
#    :reporter => Forewarn::Reporters::Json,
#    :report_destination => "log/usage_warning.json",
    :warners => [Forewarn::Warners::StringMutation]
  }.freeze

  def self.config(overrides = {})
    @__config.merge!(overrides)
  end

  def self.reset_config
    @__config = DEFAULT_CONFIG.dup
  end
  reset_config
end

