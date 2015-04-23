require 'beaker-rspec'

UNSUPPORTED_PLATFORMS = ['windows', 'Darwin']

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  # This will install the latest available package on el and deb based
  # systems fail on windows and osx, and install via gem on other *nixes
  foss_opts = {:default_action => 'gem_install'}

  if default.is_pe?; then
    install_pe;
  else
    install_puppet(foss_opts);
  end

  hosts.each do |host|
    unless host.is_pe?
      on host, "/bin/echo '' > #{host['hieraconf']}"
    end
    on host, "mkdir -p #{host['distmoduledir']}"
    if host['platform'] =~ /sles-12/i || host['platform'] =~ /solaris-11/i
      apply_manifest_on(host, 'package{"git":}')
      on host, 'git clone -b 4.6.x https://github.com/puppetlabs/puppetlabs-stdlib /etc/puppetlabs/puppet/modules/stdlib'
    else
      on host, puppet('module install puppetlabs-stdlib'), {:acceptable_exit_codes => [0, 1]}
    end

    #Need to disable update of ntp servers from DHCP, as subsequent restart of ntp causes test failures
    if fact('osfamily') == 'Debian'
      shell('[[ -f /etc/dhcp/dhclient-exit-hooks.d/ntp ]] && rm /etc/dhcp/dhcp-exit-hooks.d/ntp', { :acceptable_exit_codes => [0, 1] })
      shell('[[ -f /etc/dhcp3/dhclient-exit-hooks.d/ntp ]] && rm /etc/dhcp3/dhcp-exit-hooks.d/ntp', { :acceptable_exit_codes => [0, 1] })
    elsif fact('osfamily') == 'RedHat'
      shell('echo "PEERNTP=no" >> /etc/sysconfig/network', { :acceptable_exit_codes => [0, 1]})
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      on host, "mkdir -p #{host['distmoduledir']}/ntp"
      %w(lib manifests templates metadata.json).each do |file|
        scp_to host, "#{proj_root}/#{file}", "#{host['distmoduledir']}/ntp"
      end
    end
  end
end
