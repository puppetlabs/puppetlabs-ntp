require 'spec_helper_acceptance'

case fact('osfamily')
when 'FreeBSD'
  packagename = 'net/ntp'
when 'Gentoo'
  packagename = 'net-misc/ntp'
when 'Linux'
  case fact('operatingsystem')
  when 'ArchLinux'
    packagename = 'ntp'
  when 'Gentoo'
    packagename = 'net-misc/ntp'
  end
else
  packagename = 'ntp'
end

describe 'ntp::install class' do
  it 'installs the package' do
    apply_manifest(%{
      class { 'ntp': }
    }, :catch_failures => true)
  end

  describe package(packagename) do
    it { should be_installed }
  end
end
