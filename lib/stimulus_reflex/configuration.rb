# frozen_string_literal: true

module StimulusReflex
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end

    alias_method :config, :configuration
  end

  class Configuration
    attr_accessor :on_failed_sanity_checks, :parent_channel, :logging
    DEFAULT_LOGGING = ->(r) { "#{r.timestamp} [#{r.session_id.red}] #{r.operation_counter.magenta} #{r.reflex_info.green} -> ##{r.selector.white} #{r.operation.yellow} via #{r.mode.blue} Morph #{"to #{r.connection_id}".cyan} " }

    def initialize
      @on_failed_sanity_checks = :exit
      @parent_channel = "ApplicationCable::Channel"
      @logging = DEFAULT_LOGGING # lambda needs to be on class level to get the right binding to allow for `using Colorize`
    end
  end
end
