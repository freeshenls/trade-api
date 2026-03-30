ENV["RAILS_MASTER_KEY"] = "ecb0953851dabdd0d3fbb2aac782311e"
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
