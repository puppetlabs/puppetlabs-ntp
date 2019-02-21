require 'spec_helper_acceptance'
require 'specinfra'

case os[:family]
when 'redhat', 'freebsd', 'linux'
  servicename = 'ntpd'
when 'solaris'
  case fact('kernelrelease')
  when '5.10'
    servicename = 'network/ntp4'
  when '5.11'
    servicename = 'network/ntp'
  end
when 'aix'
  servicename = 'xntpd'
else
  servicename = if os[:family] == 'sles' && os[:release].start_with?('12', '15')
                  'ntpd'
                else
                  'ntp'
                end
end

describe 'ntp::service class', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  describe 'with a basic test' do
    pp = <<-MANIFEST
      class { 'ntp': }
    MANIFEST
    it 'sets up the service' do
      apply_manifest(pp, catch_failures: true)
      expect(service(servicename)).to be_running
      expect(service(servicename)).to be_enabled
    end
  end

  describe 'service parameters' do
    pp = <<-MANIFEST
    class { 'ntp':
      service_enable => true,
      service_ensure => running,
      service_manage => true,
      service_name   => '#{servicename}'
    }
    MANIFEST
    it 'starts the service' do
      apply_manifest(pp, catch_failures: true)
      expect(service(servicename)).to be_running
      expect(service(servicename)).to be_enabled
    end
  end

  describe 'service is unmanaged' do
    pp = <<-MANIFEST
      class { 'ntp':
        service_enable => false,
        service_ensure => stopped,
        service_manage => false,
        service_name   => '#{servicename}'
      }
    MANIFEST
    it 'shouldnt stop the service' do
      apply_manifest(pp, catch_failures: true)
      expect(service(servicename)).to be_running
      expect(service(servicename)).to be_enabled
    end
  end
end
