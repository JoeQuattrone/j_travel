ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'active_support/dependencies' #suggested line to add from this website from rafael franca
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
