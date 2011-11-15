require 'puppet'
require 'rspec-puppet'

RSpec.configure do |c|
  puts File.join(File.dirname(__FILE__), '../../')
  c.module_path = File.join(File.dirname(__FILE__), '../../')
end
