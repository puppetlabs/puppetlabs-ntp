require 'spec_helper_acceptance'

packagemanage = true

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
when 'AIX'
  packagename = 'bos.net.tcp.client'
when 'Solaris'
  case fact('operatingsystemrelease')
  when '5.10'
    packagename = ['SUNWntpr','SUNWntpu']
  when '5.11'
    packagename = 'service/network/ntp'
  end
else
  if fact('operatingsystem') == 'SLES' and fact('operatingsystemmajrelease') == '12'
    servicename = 'ntpd'
  else
    servicename = 'ntp'
  end
end

describe 'ntp::install class', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'installs the package when package_manage is set to true' do
    apply_manifest(%{
      class { 'ntp': package_manage => true }
    }, :catch_failures => true)
  end

  Array(packagename).each do |package|
    describe package(package) do
      it { should be_installed }
    end
  end

  it 'does not install the package when package_manage is set to false' do
    apply_manifest(%{
      class { 'ntp': package_manage => false }
    }, :catch_changes => true)
  end
end
