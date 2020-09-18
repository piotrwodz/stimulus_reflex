# frozen_string_literal: true

require "uri"
require "rack"
require "rails/engine"
require "active_support/all"
require "action_dispatch"
require "action_cable"
require "nokogiri"
require "cable_ready"
require "stimulus_reflex/version"
require "stimulus_reflex/reflex"
require "stimulus_reflex/element"
require "stimulus_reflex/channel"
require "stimulus_reflex/broadcasters/broadcaster"
require "stimulus_reflex/broadcasters/nothing_broadcaster"
require "stimulus_reflex/broadcasters/page_broadcaster"
require "stimulus_reflex/broadcasters/selector_broadcaster"
require "generators/stimulus_reflex_generator"
require "stimulus_reflex/node_package_version"

module StimulusReflex
	class Engine < Rails::Engine
		initializer :verify_version do
			StimulusReflex::NodePackageVersion.new.verify
		end
  end
end
