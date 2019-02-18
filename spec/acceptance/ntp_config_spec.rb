require 'spec_helper_acceptance'

case os[:family]
when 'freebsd'
  line = '0.freebsd.pool.ntp.org maxpoll 9 iburst'
when 'debian', 'ubuntu'
  line = '0.debian.pool.ntp.org iburst'
when 'fedora'
  line = '0.fedora.pool.ntp.org'
when 'redhat'
  line = '0.centos.pool.ntp.org'
when 'suse'
  line = '0.opensuse.pool.ntp.org'
when 'solaris'
  line = '0.pool.ntp.org'
when 'aix'
  line = '0.debian.pool.ntp.org iburst'
end

config = if os[:family] == 'solaris'
           '/etc/inet/ntp.conf'
         else
           '/etc/ntp.conf'
         end

describe 'ntp::config class', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  it 'sets up ntp.conf' do
    apply_manifest(%(
      class { 'ntp': }
    ), catch_failures: true)
  end

  describe file(config.to_s) do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match line }
  end
end
