require 'spec_helper_system'


describe 'ntp::service class' do
  let(:os) {
    node.facts['osfamily']
  }

  case node.facts['osfamily']
  when 'RedHat', 'FreeBSD', 'Linux'
    servicename = 'ntpd'
  else
    servicename = 'ntp'
  end

  puppet_apply(%{
    class { 'ntp': }
  })

  describe service(servicename) do
    it { should be_enabled }
    it { should be_running }
  end

end
