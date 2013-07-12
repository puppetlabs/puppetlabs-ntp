require 'spec_helper'

describe 'ntp::service' do

  ['Debian', 'RedHat', 'SuSE', 'FreeBSD', 'Archlinux'].each do |osfamily|
    describe "for osfamily #{osfamily}" do

      let(:facts) {{ :osfamily => osfamily }}
      let(:params) {{
        :service_manage => true,
        :service_enable => true,
        :service_ensure => 'running',
        :service_name   => 'ntp'
      }}

      it { should contain_service('ntp').with(
        :enable => true,
        :ensure => 'running',
        :name   => 'ntp'
      )}

      it 'should allow service ensure to be overridden' do
        params[:service_ensure] = 'stopped'
        subject.should contain_service('ntp').with_ensure('stopped')
      end
    end
  end

  ['Gentoo'].each do |operatingsystem|
    describe "for distribution #{operatingsystem}" do

      let(:facts) {{ :osfamily => 'Linux', :operatingsystem => operatingsystem }}
      let(:params) {{
        :service_manage => true,
        :service_enable => true,
        :service_ensure => 'running',
        :service_name   => 'ntpd' }
      }

      it 'should contain service' do
        should contain_service('ntp').with(
          :enable => true,
          :ensure => 'running',
          :name   => 'ntpd')
      end

      it 'should allow service ensure to be overridden' do
        params[:service_ensure] = 'stopped'
        subject.should contain_service('ntp').with_ensure('stopped')
      end

    end
  end

  describe "isn't managed if service_manage is false" do

    let(:facts) {{ :osfamily => 'Debian' }}

    let(:params) {{
      :service_manage => false,
      :service_enable => true,
      :service_ensure => 'running',
      :service_name   => 'ntpd',
    }}

    it { should_not contain_service('ntp').with(
      :enable => true,
      :ensure => 'running',
      :name   => 'ntpd'
    )}
  end

end
