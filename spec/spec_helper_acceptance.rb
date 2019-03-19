require 'beaker-pe'
require 'beaker-puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

UNSUPPORTED_PLATFORMS = ['windows', 'darwin'].freeze

run_puppet_install_helper
configure_type_defaults_on(hosts)
install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ %r{pe}i
install_module_on(hosts)
install_module_dependencies_on(hosts)

unless ENV['RS_PROVISION'] == 'no' || ENV['BEAKER_provision'] == 'no'

  hosts.each do |host|
    # Need to disable update of ntp servers from DHCP, as subsequent restart of ntp causes test failures
    if fact_on(host, 'osfamily') == 'Debian'
      on host, 'dpkg-divert --divert /etc/dhcp-ntp.bak --local --rename --add /etc/dhcp/dhclient-exit-hooks.d/ntp'
      on host, 'dpkg-divert --divert /etc/dhcp3-ntp.bak --local --rename --add /etc/dhcp3/dhclient-exit-hooks.d/ntp'
    elsif fact_on(host, 'osfamily') == 'RedHat'
      on host, 'echo "PEERNTP=no" >> /etc/sysconfig/network'
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
      copy_module_to(host, source: proj_root, module_name: 'ntp')
    end
  end
end

def idempotent_apply(hosts, manifest, opts = {}, &block)
  block_on hosts, opts do |host|
    file_path = host.tmpfile('apply_manifest.pp')
    create_remote_file(host, file_path, manifest + "\n")

    puppet_apply_opts = { :verbose => nil, 'detailed-exitcodes' => nil }
    on_options = { acceptable_exit_codes: [0, 2] }
    on host, puppet('apply', file_path, puppet_apply_opts), on_options, &block
    puppet_apply_opts2 = { :verbose => nil, 'detailed-exitcodes' => nil }
    on_options2 = { acceptable_exit_codes: [0] }
    on host, puppet('apply', file_path, puppet_apply_opts2), on_options2, &block
  end
end
