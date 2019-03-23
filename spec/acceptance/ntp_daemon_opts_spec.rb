require 'spec_helper_acceptance'

config = if os[:family] == 'redhat'
           '/etc/sysconfig/ntp'
         else
           '/etc/default/ntp'
         end

describe 'ntp class with daemon options:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'run module twice idempotently' do
    idempotent_apply(default, pp, {})
  end

  describe file(config.to_s) do
    its(:content) { is_expected.to match(%r{(OPTIONS|NTPD_OPTS)='-g -i \/var\/lib\/ntp'}) }
  end

  if fact('osfamily') == 'redhat'
    describe file('/etc/systemd/system/multi-user.target.wants/ntpd.service') do
      its(:content) { is_expected.to match(%r{ntpd -u ntp:ntp}) }
    end
  end
  if fact('osfamily') == 'debian'
    describe file('/usr/lib/ntp/ntp-systemd-wrapper') do
      its(:content) { is_expected.to match(%r{RUNASUSER=ntp}) }
    end
  end
end
