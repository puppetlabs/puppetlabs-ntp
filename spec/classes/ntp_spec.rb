require 'spec_helper'

on_supported_os.each do |os, f|
  describe 'ntp' do
    let(:facts) { { is_virtual: false } }

    let(:conf_path) do
      if os =~ %r{solaris}
        '/etc/inet/ntp.conf'
      else
        '/etc/ntp.conf'
      end
    end

    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('ntp::install') }
      it { is_expected.to contain_class('ntp::config') }
      it { is_expected.to contain_class('ntp::service') }

      describe 'ntp::config' do
        it { is_expected.to contain_file(conf_path).with_owner('0') }
        it { is_expected.to contain_file(conf_path).with_group('0') }
        it { is_expected.to contain_file(conf_path).with_mode('0644') }

        if f[:os]['family'] == 'RedHat'
          it { is_expected.to contain_file('/etc/ntp/step-tickers').with_owner('0') }
          it { is_expected.to contain_file('/etc/ntp/step-tickers').with_group('0') }
          it { is_expected.to contain_file('/etc/ntp/step-tickers').with_mode('0644') }
        end

        if f[:os]['family'] == 'Suse' && f[:os]['release']['major'] == '12'
          it { is_expected.to contain_file('/var/run/ntp/servers-netconfig').with_ensure_absent }
        end

        describe 'allows template to be overridden with erb template' do
          let(:params) { { config_template: 'my_ntp/ntp.conf.erb' } }

          it { is_expected.to contain_file(conf_path).with_content(%r{erbserver1}) }
        end

        describe 'allows template to be overridden with epp template' do
          let(:params) { { config_epp: 'my_ntp/ntp.conf.epp' } }

          it { is_expected.to contain_file(conf_path).with_content(%r{eppserver1}) }
        end

        describe 'broadcastclient' do
          context 'when set to true' do
            let(:params) do
              {
                broadcastclient: true,
              }
            end

            it 'contains broadcastclient setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^broadcastclient\n})
            end
          end
          context 'when set to false' do
            let(:params) do
              {
                broadcastclient: false,
              }
            end

            it 'does not contain broadcastclient setting' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{^broadcastclient\n})
            end
          end
        end

        describe 'burst' do
          context 'when set to true' do
            let(:params) do
              {
                burst: true,
              }
            end

            it do
              is_expected.to contain_file(conf_path).with('content' => %r{ burst\n})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                burst: false,
              }
            end

            it do
              is_expected.not_to contain_file(conf_path).with('content' => %r{ burst\n})
            end
          end
        end

        context 'config_dir' do
          context 'when set to custom dir' do
            let(:params) do
              {
                keys_enable: true,
                config_dir: '/tmp/foo',
                keys_file: '/tmp/foo/ntp.keys',
              }
            end

            it 'contains custom config directory' do
              is_expected.to contain_file('/tmp/foo').with(
                'ensure' => 'directory', 'owner' => '0', 'group' => '0', 'mode' => '0775', 'recurse' => 'false',
              )
            end
          end
        end

        context 'config_file_mode' do
          context 'when set to custom mode' do
            let(:params) do
              {
                config_file_mode: '0777',
              }
            end

            it 'contains file mode of 0777' do
              is_expected.to contain_file(conf_path).with_mode('0777')
            end
          end
        end

        context 'default pool servers' do
          case f[:os]['family']
          when 'RedHat'
            it 'uses the centos ntp servers' do
              is_expected.to contain_file('/etc/ntp.conf').with('content' => %r{server \d.centos.pool.ntp.org})
            end
            it do
              is_expected.to contain_file('/etc/ntp/step-tickers').with('content' => %r{\d.centos.pool.ntp.org})
            end
          when 'Debian'
            it 'uses the debian ntp servers' do
              is_expected.to contain_file('/etc/ntp.conf').with('content' => %r{server \d.debian.pool.ntp.org iburst\n})
            end
          when 'Suse'
            it 'uses the opensuse ntp servers' do
              is_expected.to contain_file('/etc/ntp.conf').with('content' => %r{server \d.opensuse.pool.ntp.org})
            end
          when 'FreeBSD'
            it 'uses the freebsd ntp servers' do
              is_expected.to contain_file('/etc/ntp.conf').with('content' => %r{server \d.freebsd.pool.ntp.org iburst maxpoll 9})
            end
          when 'Solaris'
            it 'uses the generic NTP pool servers' do
              is_expected.to contain_file('/etc/inet/ntp.conf').with('content' => %r{server \d.pool.ntp.org})
            end
          when 'AIX'
            it 'uses the generic NTP pool servers on AIX' do
              is_expected.to contain_file('/etc/ntp.conf').with('content' => %r{server \d.pool.ntp.org})
            end
          else
            it {
              expect { catalogue }.to raise_error(
                %r{The ntp module is not supported on an unsupported based system.},
              )
            }
          end
        end

        describe 'disable_auth' do
          context 'when set to true' do
            let(:params) do
              {
                disable_auth: true,
              }
            end

            it 'contains disable auth setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^disable auth\n})
            end
          end
          context 'when set to false' do
            let(:params) do
              {
                disable_auth: false,
              }
            end

            it 'does not contain disable auth setting' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{^disable auth\n})
            end
          end
        end

        describe 'disable_dhclient' do
          context 'when set to true' do
            let(:params) do
              {
                disable_dhclient: true,
              }
            end

            it 'contains disable ntp-servers setting' do
              is_expected.to contain_augeas('disable ntp-servers in dhclient.conf')
            end
            it 'contains dhcp file' do
              is_expected.to contain_file('/var/lib/ntp/ntp.conf.dhcp').with_ensure('absent')
            end
            it 'contains ntp.sh file' do
              is_expected.to contain_file('/etc/dhcp/dhclient.d/ntp.sh').with_ensure('absent')
            end
          end
          context 'when set to false' do
            let(:params) do
              {
                disable_dhclient: false,
              }
            end

            it 'does not contain disable ntp-servers setting' do
              is_expected.not_to contain_augeas('disable ntp-servers in dhclient.conf')
            end
            it 'does not contain dhcp file' do
              is_expected.not_to contain_file('/var/lib/ntp/ntp.conf.dhcp').with_ensure('absent')
            end
          end
        end

        describe 'disable_kernel' do
          context 'when set to true' do
            let(:params) do
              {
                disable_kernel: true,
              }
            end

            it 'contains disable kernel setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^disable kernel\n})
            end
          end
          context 'when set to false' do
            let(:params) do
              {
                disable_kernel: false,
              }
            end

            it 'does not contain disable kernel setting' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{^disable kernel\n})
            end
          end
        end

        describe 'disable_monitor' do
          context 'when default' do
            let(:params) do
              {
              }
            end

            it 'contains disable monitor setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^disable monitor\n})
            end
          end
          context 'when set to true' do
            let(:params) do
              {
                disable_monitor: true,
              }
            end

            it 'contains disable monitor setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^disable monitor\n})
            end
          end
          context 'when set to false' do
            let(:params) do
              {
                disable_monitor: false,
              }
            end

            it 'does not contain disable monitor setting' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{^disable monitor\n})
            end
          end
        end

        describe 'driftfile' do
          context 'when not set' do
            it 'contains default driftfile' do
              is_expected.to contain_file(conf_path).with('content' => %r{^driftfile})
            end
          end

          context 'when set' do
            let(:params) do
              {
                driftfile: '/tmp/driftfile',
              }
            end

            it 'contains driftfile value' do
              is_expected.to contain_file(conf_path).with('content' => %r{^driftfile /tmp/driftfile\n})
            end
          end
        end

        describe 'enable_mode7' do
          context 'when default' do
            let(:params) do
              {
              }
            end

            it 'does not contain enable mode7 setting' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{^enable mode7\n})
            end
          end
          context 'when set to true' do
            let(:params) do
              {
                enable_mode7: true,
              }
            end

            it 'contains enable mode7 setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^enable mode7\n})
            end
          end
          context 'when set to false' do
            let(:params) do
              {
                enable_mode7: false,
              }
            end

            it 'does not contain enable mode7 setting' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{^enable mode7\n})
            end
          end
        end

        describe 'interfaces' do
          context 'when set' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                interfaces: ['127.0.0.1', 'a.b.c.d'],
              }
            end

            it {
              is_expected.to contain_file(conf_path).with('content' => %r{interface ignore wildcard\ninterface listen 127.0.0.1\ninterface listen a.b.c.d})
            }
          end
          context 'when not set' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
              }
            end

            it {
              is_expected.not_to contain_file(conf_path).with('content' => %r{interface ignore wildcard})
            }
          end
        end

        describe 'interfaces_ignore' do
          context 'when set' do
            let(:params) do
              {
                interfaces: ['a.b.c.d'],
                interfaces_ignore: ['wildcard', 'ipv6'],
              }
            end

            it {
              is_expected.to contain_file(conf_path).with('content' => %r{interface ignore wildcard\ninterface ignore ipv6\ninterface listen a.b.c.d})
            }
          end
          context 'when not set' do
            let(:params) do
              {
                interfaces: ['127.0.0.1'],
                servers: ['a', 'b', 'c', 'd'],
              }
            end

            it {
              is_expected.to contain_file(conf_path).with('content' => %r{interface ignore wildcard\ninterface listen 127.0.0.1})
            }
          end
        end

        describe 'keys' do
          context 'when enabled' do
            let(:params) do
              {
                keys_enable: true,
                keys_trusted: [1, 2, 3],
                keys_controlkey: 2,
                keys_requestkey: 3,
                keys: ['1 M AAAABBBB'],
              }
            end

            let(:keys_file) do
              if os =~ %r{redhat|centos|oracle|scientific}
                '/etc/ntp/keys'
              elsif os =~ %r{solaris}
                '/etc/inet/ntp.keys'
              else
                '/etc/ntp.keys'
              end
            end

            it {
              is_expected.to contain_file(conf_path).with('content' => %r{trustedkey 1 2 3})
            }
            it {
              is_expected.to contain_file(conf_path).with('content' => %r{controlkey 2})
            }
            it {
              is_expected.to contain_file(conf_path).with('content' => %r{requestkey 3})
            }
            it {
              is_expected.to contain_file(keys_file).with('content' => %r{1 M AAAABBBB})
            }
          end
        end

        context 'when disabled' do
          let(:params) do
            {
              keys_enable: false,
              keys_trusted: [1, 2, 3],
              keys_controlkey: 2,
              keys_requestkey: 3,
            }
          end

          it {
            is_expected.not_to contain_file(conf_path).with('content' => %r{trustedkey 1 2 3})
          }
          it {
            is_expected.not_to contain_file(conf_path).with('content' => %r{controlkey 2})
          }
          it {
            is_expected.not_to contain_file(conf_path).with('content' => %r{requestkey 3})
          }
        end

        describe 'noselect servers' do
          context 'when set' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                noselect_servers: ['a', 'b'],
                iburst_enable: false,
              }
            end

            it {
              is_expected.to contain_file(conf_path).with('content' => %r{server a (maxpoll 9 )?noselect\nserver b (maxpoll 9 )?noselect\nserver c( maxpoll 9)?\nserver d( maxpoll 9)?})
            }
          end
          context 'when not set' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                noselect_servers: [],
              }
            end

            it {
              is_expected.not_to contain_file(conf_path).with('content' => %r{server a noselect})
            }
          end
        end

        describe 'preferred servers' do
          context 'when set' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                preferred_servers: ['a', 'b'],
                iburst_enable: false,
              }
            end

            it {
              is_expected.to contain_file(conf_path).with('content' => %r{server a prefer( maxpoll 9)?\nserver b prefer( maxpoll 9)?\nserver c( maxpoll 9)?\nserver d( maxpoll 9)?})
            }
          end
          context 'when not set' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                preferred_servers: [],
              }
            end

            it {
              is_expected.not_to contain_file(conf_path).with('content' => %r{server a prefer})
            }
          end
        end

        describe 'restrict' do
          context 'when not set' do
            it 'does not contain restrict value' do
              is_expected.to contain_file(conf_path).without_content(%r{^restrict test restrict})
            end
          end

          context 'when set' do
            let(:params) do
              {
                restrict: ['test restrict'],
              }
            end

            it 'contains restrict value' do
              is_expected.to contain_file(conf_path).with_content(%r{^restrict test restrict})
            end
          end
        end

        describe 'slewalways' do
          context 'when absent' do
            if f[:kernel] == 'AIX'
              it 'on AIX does contain "slewalways no"' do
                is_expected.to contain_file(conf_path).with_content(%r{^slewalways no})
              end
            else
              it 'on non-AIX does not contain a slewalways' do
                is_expected.to contain_file(conf_path).without_content(%r{^slewalways})
              end
            end
          end

          context 'when "no"' do
            let(:params) do
              {
                slewalways: 'no',
              }
            end

            it 'does contain "slewalways no"' do
              is_expected.to contain_file(conf_path).with_content(%r{^slewalways no})
            end
          end

          context 'when "yes"' do
            let(:params) do
              {
                slewalways: 'yes',
              }
            end

            it 'does contain "slewalways yes"' do
              is_expected.to contain_file(conf_path).with_content(%r{^slewalways yes})
            end
          end
        end

        describe 'statistics' do
          context 'when not set' do
            it 'does not contain statistics' do
              is_expected.to contain_file(conf_path).without_content(%r{^filegen loopstats file loopstats type day enable})
            end
          end

          context 'when set' do
            let(:params) do
              {
                statistics: ['loopstats'],
                disable_monitor: false,
              }
            end

            it 'contains statistics value' do
              is_expected.to contain_file(conf_path).with_content(%r{^filegen loopstats file loopstats type day enable})
              is_expected.to contain_file(conf_path).with_content(%r{^statsdir /var/log/ntpstats})
            end
          end
        end

        describe 'udlc' do
          context 'when not set' do
            it 'does not contain udlc' do
              is_expected.to contain_file(conf_path).without_content(%r{127.127.1.0})
            end
          end

          context 'when set' do
            let(:params) do
              {
                udlc: true,
              }
            end

            it 'contains udlc value' do
              is_expected.to contain_file(conf_path).with_content(%r{127.127.1.0})
            end
          end
        end

        describe 'udlc_stratum' do
          context 'when not set' do
            it 'does not contain udlc_stratum' do
              is_expected.to contain_file(conf_path).without_content(%r{stratum 10})
            end
          end

          context 'when set' do
            let(:params) do
              {
                udlc: true,
                udlc_stratum: 10,
              }
            end

            it 'contains udlc_stratum value' do
              is_expected.to contain_file(conf_path).with_content(%r{stratum 10})
            end
          end
        end
      end

      describe 'ntp::install' do
        let(:params) { { package_ensure: 'present', package_name: ['ntp'], package_manage: true } }

        it {
          is_expected.to contain_package('ntp').with(
            ensure: 'present',
          )
        }

        describe 'should allow package ensure to be overridden' do
          let(:params) { { package_ensure: 'latest', package_name: ['ntp'], package_manage: true } }

          it { is_expected.to contain_package('ntp').with_ensure('latest') }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) { { package_ensure: 'present', package_name: ['hambaby'], package_manage: true } }

          it { is_expected.to contain_package('hambaby') }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) { { package_manage: false, package_name: ['ntp'] } }

          it { is_expected.not_to contain_package('ntp') }
        end
      end

      describe 'ntp::service' do
        let(:params) do
          {
            service_manage: true,
            service_enable: true,
            service_ensure: 'running',
            service_name: 'ntp',
          }
        end

        describe 'with defaults' do
          it {
            is_expected.to contain_service('ntp').with(
              enable: true,
              ensure: 'running',
              name: 'ntp',
              hasstatus: true,
              hasrestart: true,
            )
          }
        end

        describe 'authprov' do
          context 'when set to true' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                authprov: '/opt/novell/xad/lib64/libw32time.so 131072:4294967295 global',
              }
            end

            it 'contains authprov setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^authprov /opt/novell/xad/lib64/libw32time.so 131072:4294967295 global\n})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
              }
            end

            it 'does not contain a authprov line' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{authprov })
            end
          end
        end

        describe 'for physical machines' do
          let :facts do
            super().merge(is_virtual: false)
          end

          it 'disallows large clock skews' do
            is_expected.not_to contain_file(conf_path).with('content' => %r{tinker panic 0})
          end
        end

        describe 'for virtual machines' do
          let :facts do
            super().merge(is_virtual: true)
          end

          it 'does not use local clock as a time source' do
            is_expected.not_to contain_file(conf_path).with('content' => %r{server.*127.127.1.0.*fudge.*127.127.1.0 stratum 10})
          end

          it 'allows large clock skews' do
            is_expected.to contain_file(conf_path).with('content' => %r{tinker panic 0})
          end
        end

        describe 'iburst_enable' do
          context 'when set to true' do
            let(:params) do
              {
                iburst_enable: true,
              }
            end

            it do
              is_expected.to contain_file(conf_path).with('content' => %r{iburst})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                iburst_enable: false,
              }
            end

            it do
              is_expected.not_to contain_file(conf_path).with('content' => %r{iburst\n})
            end
          end
        end

        describe 'leapfile' do
          context 'when set to true' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                leapfile: '/etc/leap-seconds.3629404800',
              }
            end

            it 'contains leapfile setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^leapfile \/etc\/leap-seconds\.3629404800\n})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
              }
            end

            it 'does not contain a leapfile line' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{leapfile })
            end
          end
        end

        describe 'logfile' do
          context 'when set to true' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                logfile: '/var/log/foobar.log',
              }
            end

            it 'contains logfile setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^logfile \/var\/log\/foobar\.log\n})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
              }
            end

            it 'does not contain a logfile line' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{logfile })
            end
          end
        end

        describe 'logconfig' do
          context 'when set to true' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                logconfig: '=syncall +peerinfo',
              }
            end

            it 'contains logconfig setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^logconfig =syncall \+peerinfo\n})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
              }
            end

            it 'does not contain a logconfig line' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{logconfig })
            end
          end
        end

        describe 'minpoll and maxpoll' do
          context 'when minpoll changed from default' do
            let(:params) do
              {
                minpoll: 6,
              }
            end

            it do
              is_expected.to contain_file(conf_path).with('content' => %r{minpoll 6})
            end
          end

          context 'when maxpoll changed from default' do
            let(:params) do
              {
                maxpoll: 12,
              }
            end

            it do
              is_expected.to contain_file(conf_path).with('content' => %r{maxpoll 12\n})
            end
          end

          context 'when minpoll and maxpoll changed from default simultaneously' do
            let(:params) do
              {
                minpoll: 6,
                maxpoll: 12,
              }
            end

            it do
              is_expected.to contain_file(conf_path).with('content' => %r{minpoll 6 maxpoll 12\n})
            end
          end
        end

        describe 'ntpsigndsocket' do
          context 'when set to true' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
                ntpsigndsocket: '/usr/local/samba/var/lib/ntp_signd',
              }
            end

            it 'contains ntpsigndsocket setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^ntpsigndsocket /usr/local/samba/var/lib/ntp_signd\n})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                servers: ['a', 'b', 'c', 'd'],
              }
            end

            it 'does not contain a ntpsigndsocket line' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{ntpsigndsocket })
            end
          end
        end

        describe 'peers' do
          context 'when empty' do
            let(:params) do
              {
                peers: [],
              }
            end

            it 'does not contain a peer line' do
              is_expected.to contain_file(conf_path).without_content(%r{^peer})
            end
          end

          context 'when set' do
            let(:params) do
              {
                peers: ['foo', 'bar'],
              }
            end

            it 'contains the peer lines - expectation one' do
              is_expected.to contain_file(conf_path).with_content(%r{peer foo})
            end
            it 'contains the peer lines - expectation two' do
              is_expected.to contain_file(conf_path).with_content(%r{peer bar})
            end
          end
        end

        describe 'pool' do
          context 'when empty' do
            let(:params) do
              {
                pool: [],
              }
            end

            it 'does not contain a pool line' do
              is_expected.to contain_file(conf_path).without_content(%r{^pool})
            end
          end

          context 'when set' do
            let(:params) do
              {
                pool: ['foo', 'bar'],
              }
            end

            it 'contains the pool lines - expectation one' do
              is_expected.to contain_file(conf_path).with_content(%r{pool foo})
            end
            it 'contains the pool lines - expectation two' do
              is_expected.to contain_file(conf_path).with_content(%r{pool bar})
            end
          end
        end

        describe 'service_ensure' do
          describe 'when overridden' do
            let(:params) { { service_name: 'ntp', service_ensure: 'stopped' } }

            it { is_expected.to contain_service('ntp').with_ensure('stopped') }
          end
        end

        describe 'service_hasstatus' do
          describe 'when overridden' do
            let(:params) { { service_name: 'ntp', service_hasstatus: false } }

            it { is_expected.to contain_service('ntp').with_hasstatus(false) }
          end
        end

        describe 'service_hasrestart' do
          describe 'when overridden' do
            let(:params) { { service_name: 'ntp', service_hasrestart: false } }

            it { is_expected.to contain_service('ntp').with_hasrestart(false) }
          end
        end

        describe 'service_manage' do
          let(:params) do
            {
              service_manage: false,
              service_enable: true,
              service_ensure: 'running',
              service_name: 'ntpd',
            }
          end

          it 'when set to false' do
            is_expected.not_to contain_service('ntp').with('enable' => true,
                                                           'ensure' => 'running',
                                                           'name'   => 'ntpd')
          end
        end

        describe 'tinker' do
          describe 'when set to false' do
            context 'when panic or stepout not overriden' do
              let(:params) do
                {
                  tinker: false,
                }
              end

              it do
                is_expected.not_to contain_file(conf_path).with('content' => %r{^tinker })
              end
            end

            context 'when panic overriden' do
              let(:params) do
                {
                  tinker: false,
                  panic: 257,
                }
              end

              it do
                is_expected.not_to contain_file(conf_path).with('content' => %r{^tinker })
              end
            end

            context 'when stepout overriden' do
              let(:params) do
                {
                  tinker: false,
                  stepout: 5,
                }
              end

              it do
                is_expected.not_to contain_file(conf_path).with('content' => %r{^tinker })
              end
            end

            context 'when panic and stepout overriden' do
              let(:params) do
                {
                  tinker: false,
                  panic: 257,
                  stepout: 5,
                }
              end

              it do
                is_expected.not_to contain_file(conf_path).with('content' => %r{^tinker })
              end
            end
          end

          describe 'when set to true' do
            context 'when only tinker set to true' do
              let(:params) do
                {
                  tinker: true,
                }
              end

              it do
                is_expected.not_to contain_file(conf_path).with('content' => %r{^tinker })
              end
            end

            context 'when panic changed' do
              let(:params) do
                {
                  tinker: true,
                  panic: 257,
                }
              end

              it do
                is_expected.to contain_file(conf_path).with('content' => %r{^tinker panic 257\n})
              end
            end

            context 'when stepout changed' do
              let(:params) do
                {
                  tinker: true,
                  stepout: 5,
                }
              end

              it do
                is_expected.to contain_file(conf_path).with('content' => %r{^tinker stepout 5\n})
              end
            end

            context 'when panic and stepout changed' do
              let(:params) do
                {
                  tinker: true,
                  panic: 257,
                  stepout: 5,
                }
              end

              it do
                is_expected.to contain_file(conf_path).with('content' => %r{^tinker panic 257 stepout 5\n})
              end
            end
          end
        end

        describe 'tos' do
          context 'when set to true' do
            let(:params) do
              {
                tos: true,
              }
            end

            it 'contains tos setting' do
              is_expected.to contain_file(conf_path).with('content' => %r{^tos})
            end
          end

          context 'when set to false' do
            let(:params) do
              {
                tos: false,
              }
            end

            it 'does not contain tos setting' do
              is_expected.not_to contain_file(conf_path).with('content' => %r{^tos})
            end
          end
        end
      end
    end
  end
end
