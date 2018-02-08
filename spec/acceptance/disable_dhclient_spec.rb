require 'spec_helper_acceptance'

ntp_sh = '/etc/dhcp/dhclient.d/ntp.sh'
ntp_conf_dhcp = '/var/lib/ntp/ntp.conf.dhcp'
dhclient_conf = '/files/etc/dhcp/dhclient.conf'

describe 'ntp class with disable_dhclient:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'with disable_dhclient => true' do
    let(:pp) { "class { 'ntp': disable_dhclient => true }" }

    it 'runs twice' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file(dhclient_conf.to_s) do
      its(:content) { is_expected.not_to match('ntp-servers') }
    end

    it do
      is_expected.not_to contain_file(ntp_sh.to_s)
    end

    it do
      is_expected.not_to contain_file(ntp_conf_dhcp.to_s)
    end
  end

  context 'with disable_dhclient => false' do
    let(:pp) { "class { 'ntp': disable_dhclient => false }" }

    it 'runs twice' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
