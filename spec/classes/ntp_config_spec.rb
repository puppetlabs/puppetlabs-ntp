require 'spec_helper'

describe 'ntp::config' do

  def param_value(subject, type, title, param)
    catalogue.resource(type, title).send(:parameters)[param.to_sym]
  end

  let(:params) {{:servers => 'fake.pool.ntp.org'}  }

  describe 'test platform specific resources' do

    describe "for operating system family Debian" do

      let(:params) {{}}
      let(:facts) {{ :osfamily => 'debian' }}

      it 'should use the debian ntp servers by default' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = ['server 0.debian.pool.ntp.org iburst',
         'server 1.debian.pool.ntp.org iburst',
         'server 2.debian.pool.ntp.org iburst',
         'server 3.debian.pool.ntp.org iburst']
        (content.split("\n") & expected_lines).should == expected_lines
      end

      it 'should use different restrict settings if set' do
        params[:restrict] == '127.0.0.1'
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = ['restrict 127.0.0.1']
        (content.split("\n") & expected_lines).should == expected_lines
      end
    end

    describe "for operating system family RedHat" do

      let(:params) {{}}
      let(:facts) {{ :osfamily => 'redhat' }}

      it 'should use the redhat ntp servers by default' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = [
         'server 0.centos.pool.ntp.org',
         'server 1.centos.pool.ntp.org',
         'server 2.centos.pool.ntp.org']
        (content.split("\n") & expected_lines).should == expected_lines
      end
    end

    describe "for operating system family SuSE" do

      let(:params) {{}}
      let(:facts) {{ :osfamily => 'suse' }}

      it 'should use the opensuse ntp servers by default' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = [
         'server 0.opensuse.pool.ntp.org',
         'server 1.opensuse.pool.ntp.org',
         'server 2.opensuse.pool.ntp.org',
         'server 3.opensuse.pool.ntp.org']
        (content.split("\n") & expected_lines).should == expected_lines
      end
    end

    describe "for operating system family FreeBSD" do

      let(:params) {{}}
      let(:facts) {{ :osfamily => 'freebsd' }}

      it 'should use the freebsd ntp servers by default' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = [
          "server 0.freebsd.pool.ntp.org iburst maxpoll 9",
          "server 1.freebsd.pool.ntp.org iburst maxpoll 9",
          "server 2.freebsd.pool.ntp.org iburst maxpoll 9",
          "server 3.freebsd.pool.ntp.org iburst maxpoll 9"]
        (content.split("\n") & expected_lines).should == expected_lines
      end

      describe "for operating system family Archlinux" do
  
        let(:params) {{}}
        let(:facts) {{ :osfamily => 'Archlinux' }}
  
        it 'should use the NTP pool servers by default' do
          content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
          expected_lines = [
            "server 0.pool.ntp.org",
            "server 1.pool.ntp.org",
            "server 2.pool.ntp.org"]
          (content.split("\n") & expected_lines).should == expected_lines
        end
      end

      describe "for operating system family unsupported" do
        let(:facts) {{
          :osfamily  => 'unsupported',
        }}

        it { expect{ subject }.to raise_error(
          /^The ntp module is not supported on an unsupported based system./
        )}
      end

    end

    describe 'for virtual machines' do

      let(:params) {{}}
      let(:facts) {{ :osfamily        => 'Archlinux',
                     :is_virtual      => 'true' }}

      it 'should not use local clock as a time source' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = [
          'server  127.127.1.0  # local clock',
          'fudge  127.127.1.0 stratum 10' ]
        (content.split("\n") & expected_lines).should_not == expected_lines
      end

      it 'allows large clock skews' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = [ 'tinker panic 0' ]
        (content.split("\n") & expected_lines).should == expected_lines
      end

    end

    describe 'for physical machines' do

      let(:params) {{}}
      let(:facts) {{ :osfamily        => 'Archlinux',
                     :is_virtual      => 'false' }}

      it 'disallows large clock skews' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = [ 'tinker panic 0' ]
        (content.split("\n") & expected_lines).should_not == expected_lines
      end

    end

    describe "for operating system Gentoo" do

      let(:params) {{}}
      let(:facts) {{ :operatingsystem => 'Gentoo',
                      :osfamily        => 'Linux' }}


      it 'should use the NTP pool servers by default' do
        content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
        expected_lines = [
          "server 0.gentoo.pool.ntp.org",
          "server 1.gentoo.pool.ntp.org",
          "server 2.gentoo.pool.ntp.org",
          "server 3.gentoo.pool.ntp.org"]
        (content.split("\n") & expected_lines).should == expected_lines
      end
    end

    ['Debian', 'RedHat','SuSE', 'FreeBSD', 'Archlinux'].each do |osfamily|
      describe "for operating system family #{osfamily}" do

        let(:facts) {{ :osfamily => osfamily }}

        it { should contain_file('/etc/ntp.conf').with_owner('0') }
        it { should contain_file('/etc/ntp.conf').with_group('0') }
        it { should contain_file('/etc/ntp.conf').with_mode('0644') }
        it 'should allow template to be overridden' do
          params[:config_template] = 'my_ntp/ntp.conf.erb'
          content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
          expected_lines = ['server foobar']
          (content.split("\n") & expected_lines).should == expected_lines
        end
      end
    end
  end
end
