require 'spec_helper_acceptance'

case fact('osfamily')
when 'FreeBSD'
  line = '0.freebsd.pool.ntp.org maxpoll 9 iburst'
when 'Debian'
  line = '0.debian.pool.ntp.org iburst'
when 'RedHat'
  line = '0.centos.pool.ntp.org'
when 'Suse'
  line = '0.opensuse.pool.ntp.org'
when 'Gentoo'
  line = '0.gentoo.pool.ntp.org'
when 'Linux'
  case fact('operatingsystem')
  when 'ArchLinux'
    line = '0.pool.ntp.org'
  when 'Gentoo'
    line = '0.gentoo.pool.ntp.org'
  end
when 'Solaris'
  line = '0.pool.ntp.org'
when 'AIX'
  line = '0.debian.pool.ntp.org iburst'
end

if (fact('osfamily') == 'Solaris')
  config = '/etc/inet/ntp.conf'
else
  config = '/etc/ntp.conf'
end

describe 'ntp::config class', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'sets up ntp.conf' do
    apply_manifest(%{
      class { 'ntp': }
    }, :catch_failures => true)
  end

  describe file("#{config}") do
    it { should be_file }
    its(:content) { should match line }
  end
end
