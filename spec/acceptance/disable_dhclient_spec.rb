require 'spec_helper_acceptance'

describe 'ntp class with disable_dhclient:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'with should disable' do
    let(:pp) { "class { 'ntp': disable_dhclient => true }" }

    it 'runs twice' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/files/etc/dhcp/dhclient.conf') do
      its(:content) { is_expected.not_to match('ntp-servers') }
    end

    it {
      should contain_file('/etc/dhcp/dhclient.d/ntp.sh').with(
        'ensure' => 'absent',
        'backup' => 'true',
      )
      should contain_file('/var/lib/ntp/ntp.conf.dhcp').with(
        'ensure' => 'absent',
      )
    }
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
