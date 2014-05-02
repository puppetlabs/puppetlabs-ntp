require 'beaker-rspec'

UNSUPPORTED_PLATFORMS = [ 'windows', 'Solaris' ]

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  if hosts.first.is_pe?
    install_pe
  else
    install_puppet
  end
  hosts.each do |host|
    on hosts, "mkdir -p #{host['distmoduledir']}"
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'ntp')
    hosts.each do |host|
      shell("/bin/touch #{default['puppetpath']}/hiera.yaml")
      shell('puppet module install puppetlabs-stdlib', :acceptable_exit_codes => [0,1])
    end
  end
end
