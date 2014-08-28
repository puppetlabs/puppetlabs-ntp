require 'beaker-rspec'

UNSUPPORTED_PLATFORMS = [ 'windows', 'Darwin' ]

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  # This will install the latest available package on el and deb based
  # systems fail on windows and osx, and install via gem on other *nixes
  foss_opts = { :default_action => 'gem_install' }

  if default.is_pe?; then install_pe; else install_puppet( foss_opts ); end

  hosts.each do |host|
    unless host.is_pe?
      on host, "/bin/echo '' > #{host['hieraconf']}"
    end
    on host, "mkdir -p #{host['distmoduledir']}"
    on host, 'puppet module install puppetlabs-stdlib', :acceptable_exit_codes => [0,1]
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(:source => proj_root, :module_name => 'ntp')
  end
end
