require 'spec_helper_acceptance'

case os[:family]
when 'freebsd'
  packagename = 'net/ntp'
when 'aix'
  packagename = 'bos.net.tcp.client'
when 'solaris'
  case fact('kernelrelease')
  when '5.10'
    packagename = ['SUNWntp4r', 'SUNWntp4u']
  when '5.11'
    packagename = 'service/network/ntp'
  end
end

describe 'ntp::install class', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  it 'installs the package' do
    apply_manifest(%(
      class { 'ntp': }
    ), catch_failures: true)
    Array(packagename).each do |package|
      expect(package(package)).to be_installed
    end
  end
end
