require 'spec_helper_system'

describe 'ntp::config class' do
  let(:os) {
    node.facts['osfamily']
  }

  puppet_apply(%{
    class { 'ntp': }
  })

  case node.facts['osfamily']
  when 'FreeBSD'
    line = '0.freebsd.pool.ntp.org iburst maxpoll 9'
  when 'Debian'
    line = '0.debian.pool.ntp.org iburst'
  when 'RedHat'
    line = '0.centos.pool.ntp.org'
  when 'SuSE'
    line = '0.opensuse.pool.ntp.org'
  when 'Linux'
    case node.facts['operatingsystem']
    when 'ArchLinux'
      line = '0.pool.ntp.org'
    when 'Gentoo'
      line = '0.gentoo.pool.ntp.org'
    end
  end

  describe file('/etc/ntp.conf') do
    it { should be_file }
    it { should contain line }
  end

end
