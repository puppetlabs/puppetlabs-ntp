require 'beaker-rspec'
require 'beaker/puppet_install_helper'

UNSUPPORTED_PLATFORMS = ['windows', 'Darwin']

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'

  run_puppet_install_helper

  hosts.each do |host|
    # Solaris 11 doesn't ship the SSL CA root for the forgeapi server
    # therefore we need to use a different way to deploy the module to
    # the host
    if host['platform'] =~ /solaris-11/i
      apply_manifest_on(host, 'package { "git": }')
      # PE 3.x and 2015.2 require different locations to install modules
      modulepath = host.puppet['modulepath']
      modulepath = modulepath.split(':').first if modulepath

      environmentpath = host.puppet['environmentpath']
      environmentpath = environmentpath.split(':').first if environmentpath

      destdir = modulepath || "#{environmentpath}/production/modules"
      on host, "git clone -b 4.6.0 https://github.com/puppetlabs/puppetlabs-stdlib #{destdir}/stdlib"
    else
      on host, puppet('module install puppetlabs-stdlib')
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
