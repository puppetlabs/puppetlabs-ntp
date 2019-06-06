# frozen_string_literal: true

UNSUPPORTED_PLATFORMS = ['windows', 'darwin'].freeze

def disable_ntp_update_from_dhcp
  # Need to disable update of ntp servers from DHCP, as subsequent restart of ntp causes test failures
  if os[:family] == 'debian'
    run_shell('dpkg-divert --divert /etc/dhcp-ntp.bak --local --rename --add /etc/dhcp/dhclient-exit-hooks.d/ntp')
    run_shell('dpkg-divert --divert /etc/dhcp3-ntp.bak --local --rename --add /etc/dhcp3/dhclient-exit-hooks.d/ntp')
  elsif os[:family] == 'redhat'
    run_shell('echo "PEERNTP=no" >> /etc/sysconfig/network')
  end
end
