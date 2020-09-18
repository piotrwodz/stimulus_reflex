# frozen_string_literal: true

class StimulusReflex::NodePackageVersion
	attr_accessor :package_json_file_path

	NODE_PACKAGE_REGEX = /(\d+)\.(\d+)\.(\d+)/.freeze
	
	def initialize
		@package_json_file_path = Rails.root.join("package.json")
	end

	def verify
		return unless package_json_file_exists?

		raise_versions_mismatch_error if gem_and_node_package_versions_mismatch?
	end

	private

	def package_json_file_exists?
		File.exists?(package_json_file_path)
	end

	def gem_and_node_package_versions_mismatch?
		gem_version != node_package_version
	end

	def gem_version
		@gem_version ||= StimulusReflex::VERSION.gsub(".pre", "-pre")
	end

	def node_package_version
		@node_package_version ||= package_json_file["dependencies"]["stimulus_reflex"].match(NODE_PACKAGE_REGEX)
	end

	def package_json_file
		JSON.parse(File.read(package_json_file_path))
	end

	def raise_versions_mismatch_error
		puts <<~WARN
			There is a version mismatch between the stimulus_reflex gem 
			(#{gem_version}) and node package (#{node_package_version}).
			Ensure the installed version of the gem is the same as the version of the node package.
			Do not use ^ or ~ in your package.json for stimulus_reflex.

			To upgrade stimulus_reflex node package, run:
			yarn upgrade stimulus_reflex@#{gem_version}
			in the directory containing folder node_modules.
		WARN
	end
end
