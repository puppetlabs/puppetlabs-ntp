require 'spec_helper_system'


describe 'ntp::install class' do
  let(:os) {
    node.facts['osfamily']
  }

  case node.facts['osfamily']
  when 'FreeBSD'
    packagename = 'net/ntp'
  when 'Linux'
    case node.facts['operatingsystem']
    when 'ArchLinux'
      packagename = 'ntp'
    when 'Gentoo'
      packagename = 'net-misc/ntp'
    end
  else
    packagename = 'ntp'
  end

  puppet_apply(%{
    class { 'ntp': }
  })

  describe package(packagename) do
    it { should be_installed }
  end

end
