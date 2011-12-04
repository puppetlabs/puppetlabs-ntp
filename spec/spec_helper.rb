require 'puppet'
require 'rspec-puppet'
require 'tmpdir'

RSpec.configure do |c|
  c.before :each do
    # Create a temporary puppet confdir area and temporary site.pp so
    # when rspec-puppet runs we don't get a puppet error.
    @puppetdir = Dir.mktmpdir("ntp")
    manifestdir = File.join(@puppetdir, "manifests")
    Dir.mkdir(manifestdir)
    FileUtils.touch(File.join(manifestdir, "site.pp"))
    Puppet[:confdir] = @puppetdir
  end

  c.after :each do
    FileUtils.remove_entry_secure(@puppetdir)
  end

  c.module_path = File.join(File.dirname(__FILE__), '../../')
end
