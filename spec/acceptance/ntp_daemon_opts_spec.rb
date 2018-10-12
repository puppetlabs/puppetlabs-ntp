require 'spec_helper_acceptance'

config = if fact('osfamily') == 'redhat'
           '/etc/sysconfig/ntp'
         else
           '/etc/default/ntp'
         end

describe 'ntp class with daemon options:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'when successful' do
    let(:pp) { "class { 'ntp': user => 'ntp', options => '-g -i /var/lib/ntp' }" }

    it 'runs twice' do
      2.times do
        apply_manifest(pp, catch_failures: true) do |r|
          expect(r.stderr).not_to match(%r{error}i)
        end
      end
    end
  end

  describe file(config.to_s) do
    its(:content) { is_expected.to match(/(OPTIONS|NTPD_OPTS)='-g -i /var/lib/ntp'/) }
  end

  if fact('osfamily') == 'redhat'
    describe file('/etc/systemd/system/multi-user.target.wants/ntpd.service') do
      its(:content) { is_expected.to match(/ntpd -u ntp:ntp/) }
    end
  end
  if fact('osfamily') == 'debian'
    describe file('/usr/lib/ntp/ntp-systemd-wrapper') do
      its(:content) { is_expected.to match(/RUNASUSER=ntp/) }
    end
  end

end
