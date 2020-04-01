require 'spec_helper_acceptance'

case os[:family]
when 'redhat', 'freebsd', 'linux'
  servicename = 'ntpd'
when 'solaris'
  case fact('kernelrelease')
  when '5.10'
    servicename = 'network/ntp4'
  when '5.11'
    servicename = 'network/ntp'
  end
when 'aix'
  servicename = 'xntpd'
else
  servicename = if os[:family] == 'sles' && os[:release].start_with?('12', '15')
                  'ntpd'
                else
                  'ntp'
                end
end
config = if os[:family] == 'redhat'
           '/etc/sysconfig/ntpd'
         elsif os[:family] == 'sles'
           '/etc/sysconfig/ntp'
         else
           '/etc/default/ntp'
         end
describe 'ntp class with daemon options:', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) || (os[:release].start_with?('5') && os[:family] == 'redhat') do
  let(:pp) { "class { 'ntp': service_enable => true, service_ensure => running, service_manage => true, service_name => '#{servicename}', user => 'ntp', daemon_extra_opts => '-g -i /var/lib/ntp' }" }

  context 'when run' do
    it 'is successful' do
      apply_manifest(pp, catch_failures: true)
    end

    describe file(config.to_s) do
      its(:content) { is_expected.to match(%r{(OPTIONS|NTPD_OPTS)='-g -i \/var\/lib\/ntp'}) }
    end
    if os[:family] == 'redhat' && !os[:release].start_with?('6')
      describe file('/etc/systemd/system/multi-user.target.wants/ntpd.service') do
        its(:content) { is_expected.to match(%r{ntpd -u ntp:ntp}) }
      end
    elsif os[:family] == 'ubuntu' && os[:release].start_with?('18')
      describe file('/usr/lib/ntp/ntp-systemd-wrapper') do
        its(:content) { is_expected.to match(%r{RUNASUSER=ntp}) }
      end
    end
  end
end
