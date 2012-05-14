require 'puppet'
require 'rspec-puppet'
require 'puppet_spec_helper'

fixture_dir = File.join(dir = File.expand_path(File.dirname(__FILE__)), "fixtures")

RSpec.configure do |c|
  c.module_path = File.join(fixture_dir, 'modules')
  c.manifest_dir = File.join(fixture_dir, 'manifests')
end
