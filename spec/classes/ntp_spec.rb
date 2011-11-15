#!/usr/bin/env rspec
require 'spec_helper'

describe 'ntp' do

  def param_value(subject, type, title, param)
    catalogue.resource(type, title).send(:parameters)[param.to_sym]
  end

  let(:params) { {:servers => 'fake.pool.ntp.org'}  }

  describe 'test platform specific resources' do

    debianish = ['debian', 'ubuntu']
    redhatish = ['centos', 'redhat', 'oel', 'linux']

    debianish.each do |os|
      describe "for operating system #{os}" do

        let(:params) {{}}
        let(:facts) { { :operatingsystem => os } }

        it { should contain_service('ntp').with_name('ntp') }
        it 'should use the debian ntp servers by default' do
          content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
          expected_lines = ['server 0.debian.pool.ntp.org iburst',
           'server 1.debian.pool.ntp.org iburst',
           'server 2.debian.pool.ntp.org iburst',
           'server 3.debian.pool.ntp.org iburst']
          (content.split("\n") & expected_lines).should == expected_lines
        end
      end
    end

    redhatish.each do |os|
      describe "for operating system #{os}" do

        let(:params) {{}}
        let(:facts) { { :operatingsystem => os } }

        it { should contain_service('ntp').with_name('ntpd') }
        it 'should use the redhat ntp servers by default' do
          content = param_value(subject, 'file', '/etc/ntp.conf', 'content')
          expected_lines = [
           'server 0.centos.pool.ntp.org',
           'server 1.centos.pool.ntp.org',
           'server 2.centos.pool.ntp.org']
          (content.split("\n") & expected_lines).should == expected_lines
        end
      end
    end

    (redhatish + debianish).each do |os|
      describe "for operating system #{os}" do

        let(:facts) { { :operatingsystem => os } }

        it { should contain_file('/etc/ntp.conf').with_owner('0') }
        it { should contain_file('/etc/ntp.conf').with_group('0') }
        it { should contain_file('/etc/ntp.conf').with_mode('0644') }
        it { should contain_package('ntp').with_ensure('present') }
        it { should contain_service('ntp').with_ensure('running') }
        it { should contain_service('ntp').with_hasstatus(true) }
        it { should contain_service('ntp').with_hasrestart(true) }
        it 'should allow service ensure to be overridden' do
          params[:ensure] = 'stopped'
          subject.should contain_service('ntp').with_ensure('stopped')
        end
        it 'should allow package ensure to be overridden' do
          params[:autoupdate] = true
          subject.should contain_package('ntp').with_ensure('latest')
        end
      end
    end
  end
end
