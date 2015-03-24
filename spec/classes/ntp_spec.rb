require 'spec_helper'

describe 'ntp' do
  let(:facts) {{ :is_virtual => 'false' }}

  ['Debian', 'RedHat','Suse', 'FreeBSD', 'Archlinux', 'Gentoo', 'Gentoo (Facter < 1.7)'].each do |system|
    context "when on system #{system}" do
      if system == 'Gentoo (Facter < 1.7)'
        let :facts do
          super().merge({ :osfamily => 'Linux', :operatingsystem => 'Gentoo' })
        end
      elsif system == 'Suse'
        let :facts do
          super().merge({ :osfamily => system,:operatingsystem => 'SLES',:operatingsystemmajrelease => '11' })
        end
      else
        let :facts do
          super().merge({ :osfamily => system })
        end
      end

      it { should contain_class('ntp::install') }
      it { should contain_class('ntp::config') }
      it { should contain_class('ntp::service') }

      describe "ntp::config on #{system}" do
        it { should contain_file('/etc/ntp.conf').with_owner('0') }
        it { should contain_file('/etc/ntp.conf').with_group('0') }
        it { should contain_file('/etc/ntp.conf').with_mode('0644') }

        describe 'allows template to be overridden' do
          let(:params) {{ :config_template => 'my_ntp/ntp.conf.erb' }}
          it { should contain_file('/etc/ntp.conf').with({
            'content' => /server foobar/})
          }
        end

        describe "keys for osfamily #{system}" do
          context "when enabled" do
            let(:params) {{
              :keys_enable     => true,
              :keys_file       => '/etc/ntp/ntp.keys',
              :keys_trusted    => ['1', '2', '3'],
              :keys_controlkey => '2',
              :keys_requestkey => '3',
            }}

            it { should contain_file('/etc/ntp').with({
              'ensure'  => 'directory'})
            }
            it { should contain_file('/etc/ntp.conf').with({
              'content' => /trustedkey 1 2 3/})
            }
            it { should contain_file('/etc/ntp.conf').with({
              'content' => /controlkey 2/})
            }
            it { should contain_file('/etc/ntp.conf').with({
              'content' => /requestkey 3/})
            }
          end
        end

        context "when disabled" do
          let(:params) {{
            :keys_enable     => false,
            :keys_file       => '/etc/ntp/ntp.keys',
            :keys_trusted    => ['1', '2', '3'],
            :keys_controlkey => '2',
            :keys_requestkey => '3',
          }}

          it { should_not contain_file('/etc/ntp').with({
            'ensure'  => 'directory'})
          }
          it { should_not contain_file('/etc/ntp.conf').with({
            'content' => /trustedkey 1 2 3/})
          }
          it { should_not contain_file('/etc/ntp.conf').with({
            'content' => /controlkey 2/})
          }
          it { should_not contain_file('/etc/ntp.conf').with({
            'content' => /requestkey 3/})
          }
        end

        describe 'preferred servers' do
          context "when set" do
            let(:params) {{
              :servers           => ['a', 'b', 'c', 'd'],
              :preferred_servers => ['a', 'b']
            }}

            it { should contain_file('/etc/ntp.conf').with({
              'content' => /server a( iburst)? prefer\nserver b( iburst)? prefer\nserver c( iburst)?\nserver d( iburst)?/})
            }
          end
          context "when not set" do
            let(:params) {{
              :servers           => ['a', 'b', 'c', 'd'],
              :preferred_servers => []
            }}

            it { should_not contain_file('/etc/ntp.conf').with({
              'content' => /server a prefer/})
            }
          end
        end
        describe 'specified interfaces' do
          context "when set" do
            let(:params) {{
              :servers           => ['a', 'b', 'c', 'd'],
              :interfaces        => ['127.0.0.1', 'a.b.c.d']
            }}

            it { should contain_file('/etc/ntp.conf').with({
              'content' => /interface ignore wildcard\ninterface listen 127.0.0.1\ninterface listen a.b.c.d/})
            }
          end
          context "when not set" do
            let(:params) {{
              :servers           => ['a', 'b', 'c', 'd'],
            }}

            it { should_not contain_file('/etc/ntp.conf').with({
              'content' => /interface ignore wildcard/})
            }
          end
        end
        describe 'with parameter disable_auth' do
          context 'when set to true' do
            let(:params) {{
              :disable_auth => true,
            }}

            it 'should contain disable auth setting' do
              should contain_file('/etc/ntp.conf').with({
              'content' => /^disable auth\n/,
              })
            end
          end
          context 'when set to false' do
            let(:params) {{
              :disable_auth => false,
            }}

            it 'should not contain disable auth setting' do
              should_not contain_file('/etc/ntp.conf').with({
              'content' => /^disable auth\n/,
              })
            end
          end
        end
        describe 'with parameter broadcastclient' do
          context 'when set to true' do
            let(:params) {{
              :broadcastclient => true,
            }}

            it 'should contain broadcastclient setting' do
              should contain_file('/etc/ntp.conf').with({
              'content' => /^broadcastclient\n/,
              })
            end
          end
          context 'when set to false' do
            let(:params) {{
              :broadcastclient => false,
            }}

            it 'should not contain broadcastclient setting' do
              should_not contain_file('/etc/ntp.conf').with({
              'content' => /^broadcastclient\n/,
              })
            end
          end
        end

        describe "ntp::install on #{system}" do
          let(:params) {{ :package_ensure => 'present', :package_name => ['ntp'], :package_manage => true, }}

          it { should contain_package('ntp').with(
            :ensure => 'present'
          )}

          describe 'should allow package ensure to be overridden' do
            let(:params) {{ :package_ensure => 'latest', :package_name => ['ntp'], :package_manage => true, }}
            it { should contain_package('ntp').with_ensure('latest') }
          end

          describe 'should allow the package name to be overridden' do
            let(:params) {{ :package_ensure => 'present', :package_name => ['hambaby'], :package_manage => true, }}
            it { should contain_package('hambaby') }
          end

          describe 'should allow the package to be unmanaged' do
            let(:params) {{ :package_manage => false, :package_name => ['ntp'], }}
            it { should_not contain_package('ntp') }
          end
        end

        describe 'ntp::service' do
          let(:params) {{
            :service_manage => true,
            :service_enable => true,
            :service_ensure => 'running',
            :service_name   => 'ntp'
          }}

          describe 'with defaults' do
            it { should contain_service('ntp').with(
              :enable => true,
              :ensure => 'running',
              :name   => 'ntp'
            )}
          end

          describe 'service_ensure' do
            describe 'when overridden' do
              let(:params) {{ :service_name => 'ntp', :service_ensure => 'stopped' }}
              it { should contain_service('ntp').with_ensure('stopped') }
            end
          end

          describe 'service_manage' do
            let(:params) {{
              :service_manage => false,
              :service_enable => true,
              :service_ensure => 'running',
              :service_name   => 'ntpd',
            }}

            it 'when set to false' do
              should_not contain_service('ntp').with({
                'enable' => true,
                'ensure' => 'running',
                'name'   => 'ntpd'
              })
            end
          end
        end

        describe 'with parameter iburst_enable' do
          context 'when set to true' do
            let(:params) {{
              :iburst_enable => true,
            }}

            it do
              should contain_file('/etc/ntp.conf').with({
              'content' => /iburst\n/,
              })
            end
          end

          context 'when set to false' do
            let(:params) {{
              :iburst_enable => false,
            }}

            it do
              should_not contain_file('/etc/ntp.conf').with({
                'content' => /iburst\n/,
              })
            end
          end
        end

        describe 'with parameter logfile' do
          context 'when set to true' do
            let(:params) {{
              :servers => ['a', 'b', 'c', 'd'],
              :logfile => '/var/log/foobar.log',
            }}

            it 'should contain logfile setting' do
              should contain_file('/etc/ntp.conf').with({
              'content' => /^logfile \/var\/log\/foobar\.log\n/,
              })
            end
          end

          context 'when set to false' do
            let(:params) {{
              :servers => ['a', 'b', 'c', 'd'],
            }}

            it 'should not contain a logfile line' do
              should_not contain_file('/etc/ntp.conf').with({
                'content' => /logfile /,
              })
            end
          end
        end
      end
    end

    context 'ntp::config' do
      describe "for operating system Gentoo (Facter < 1.7)" do
        let :facts do
          super().merge({ :operatingsystem => 'Gentoo',
                       :osfamily        => 'Linux' })
        end

        it 'uses the NTP pool servers by default' do
          should contain_file('/etc/ntp.conf').with({
            'content' => /server \d.gentoo.pool.ntp.org/,
          })
        end
      end

      describe "on osfamily Gentoo" do
        let :facts do
          super().merge({ :osfamily => 'Gentoo' })
        end

        it 'uses the NTP pool servers by default' do
          should contain_file('/etc/ntp.conf').with({
            'content' => /server \d.gentoo.pool.ntp.org/,
          })
        end
      end

      describe "on osfamily Debian" do
        let :facts do
          super().merge({ :osfamily => 'debian' })
        end

        it 'uses the debian ntp servers by default' do
          should contain_file('/etc/ntp.conf').with({
            'content' => /server \d.debian.pool.ntp.org iburst\n/,
          })
        end
      end

      describe "on osfamily RedHat" do
        let :facts do
          super().merge({ :osfamily => 'RedHat' })
        end

        it 'uses the redhat ntp servers by default' do
          should contain_file('/etc/ntp.conf').with({
            'content' => /server \d.centos.pool.ntp.org/,
          })
        end
      end

      describe "on osfamily Suse" do
        let :facts do
          super().merge({ :osfamily => 'Suse', :operatingsystem => 'SLES',:operatingsystemmajrelease => '11' })
        end

        it 'uses the opensuse ntp servers by default' do
          should contain_file('/etc/ntp.conf').with({
            'content' => /server \d.opensuse.pool.ntp.org/,
            })
        end
      end

      describe "on osfamily FreeBSD" do
        let :facts do
          super().merge({ :osfamily => 'FreeBSD' })
        end

        it 'uses the freebsd ntp servers by default' do
          should contain_file('/etc/ntp.conf').with({
            'content' => /server \d.freebsd.pool.ntp.org maxpoll 9 iburst/,
          })
        end
      end

      describe "on osfamily ArchLinux" do
        let :facts do
          super().merge({ :osfamily => 'ArchLinux' })
        end

        it 'uses the NTP pool servers by default' do
          should contain_file('/etc/ntp.conf').with({
            'content' => /server \d.pool.ntp.org/,
          })
        end
      end

      describe "on osfamily Solaris and operatingsystemrelease 5.10" do
        let :facts do
          super().merge({ :osfamily => 'Solaris', :operatingsystemrelease => '5.10' })
        end

        it 'uses the NTP pool servers by default' do
          should contain_file('/etc/inet/ntp.conf').with({
            'content' => /server \d.pool.ntp.org/,
          })
        end
      end

      describe "on osfamily Solaris and operatingsystemrelease 5.11" do
        let :facts do
          super().merge({ :osfamily => 'Solaris', :operatingsystemrelease => '5.11' })
        end

        it 'uses the NTP pool servers by default' do
          should contain_file('/etc/inet/ntp.conf').with({
            'content' => /server \d.pool.ntp.org/,
          })
        end
      end

      describe "for operating system family unsupported" do
        let :facts do
          super().merge({
          :osfamily  => 'unsupported',
        })
        end

        it { expect{ catalogue }.to raise_error(
          /The ntp module is not supported on an unsupported based system./
        )}
      end
    end

    describe 'for virtual machines' do
      let :facts do
        super().merge({ :osfamily        => 'Archlinux',
                     :is_virtual      => 'true' })
      end

      it 'should not use local clock as a time source' do
        should_not contain_file('/etc/ntp.conf').with({
          'content' => /server.*127.127.1.0.*fudge.*127.127.1.0 stratum 10/,
        })
      end

      it 'allows large clock skews' do
        should contain_file('/etc/ntp.conf').with({
          'content' => /tinker panic 0/,
        })
      end
    end

    describe 'for physical machines' do
      let :facts do
        super().merge({ :osfamily        => 'Archlinux',
                     :is_virtual      => 'false' })
      end

      it 'disallows large clock skews' do
        should_not contain_file('/etc/ntp.conf').with({
          'content' => /tinker panic 0/,
        })
      end
    end
  end
end
