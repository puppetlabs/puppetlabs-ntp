require 'spec_helper'

describe 'ntp::install' do

  ['Debian', 'RedHat', 'SuSE', 'FreeBSD', 'Archlinux'].each do |osfamily|
    describe "for osfamily #{osfamily}" do

      let(:facts) {{ :osfamily => osfamily }}
      let(:params) {{
        :package_ensure => 'present',
        :package_name   => 'ntp',
      }}

      it { should contain_package('ntp').with(
        :ensure => 'present',
        :name   => 'ntp'
      )}

      it 'should allow package ensure to be overridden' do
        params[:package_ensure] = 'latest'
        subject.should contain_package('ntp').with_ensure('latest')
      end

      it 'should allow the package name to be overridden' do
        params[:package_name] = 'hambaby'
        subject.should contain_package('ntp').with_name('hambaby')
      end

    end
  end

  describe "for distribution gentoo" do

    let(:facts) {{ :osfamily => 'Linux', :operatingsystem => 'Gentoo' }}
    let(:params) {{
      :package_ensure => 'present',
      :package_name   => 'net-misc/ntp',
    }}

    it { should contain_package('ntp').with(
      :ensure => 'present',
      :name   => 'net-misc/ntp'
    )}

    it 'should allow package ensure to be overridden' do
      params[:package_ensure] = 'latest'
      subject.should contain_package('ntp').with_ensure('latest')
    end

  end

end
