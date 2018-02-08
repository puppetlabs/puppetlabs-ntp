require 'spec_helper_acceptance'

ntp_sh = '/etc/dhcp/dhclient.d/ntp.sh'
ntp_conf_dhcp = '/var/lib/ntp/ntp.conf.dhcp'
dhclient_conf = '/files/etc/dhcp/dhclient.conf'

describe 'ntp class with disable_dhclient:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'with should disable' do
    let(:pp) { "class { 'ntp': disable_dhclient => true }" }

    it 'runs twice' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file(dhclient_conf.to_s) do
      its(:content) { is_expected.not_to match('ntp-servers') }
    end

    describe file(ntp_sh.to_s) do
      it { is_expected.to contain_file(ntp_sh.to_s).with(
        'ensure' => 'absent',
        'backup' => 'true',
        )
      }
    end

    describe file(ntp_conf_dhcp.to_s) do
      it { is_expected.to contain_file(ntp_conf_dhcp.to_s).with('ensure' => 'absent') }
    end
  end

  context 'when enabled' do
    let(:pp) { "class { 'ntp': disable_dhclient => false }" }

    it 'runs twice' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/files/etc/dhcp/dhclient.conf') do
      its(:content) { is_expected.to match('ntp-servers') }
    end
  end
end
