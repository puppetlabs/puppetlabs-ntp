# Class: ntp::params
#
#   This module manages the ntp service.
#
#   Jeff McCune <jeff@puppetlabs.com>
#   2011-02-23
#   Eric Shamow <eric@puppetlabs.com>
#   2012-04-02
#
#   Tested platforms:
#    - Debian 6.0 Squeeze
#    - CentOS 5.7
#    - CentOS 6.2
#    - Amazon Linux 2011.09 - needs retest
#
# Parameters:
#
# Actions:
#
# Provides default parameters for ntp class when parameterized classes
# can't be used
#
# Requires:
#
# ntp
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class ntp::params($hiera_enabled=false) {

  if $hiera_enabled == true {
    $supported    = hiera('ntp_supported')
    $pkg_name     = hiera('ntp_pkg')
    $svc_name     = hiera('ntp_svc')
    $config       = hiera('ntp_config')
    $config_tpl   = hiera('ntp_config_tpl')
    $servers_real = hiera('ntp_servers_real')
  } else {
    case $::operatingsystem {
      debian, ubuntu: {
        $supported  = true
        $pkg_name   = [ 'ntp' ]
        $svc_name   = 'ntp'
        $config     = '/etc/ntp.conf'
        $config_tpl = 'ntp.conf.debian.erb'
        if ($ntp::servers == 'UNSET') {
          $servers_real = [ '0.debian.pool.ntp.org iburst',
                            '1.debian.pool.ntp.org iburst',
                            '2.debian.pool.ntp.org iburst',
                            '3.debian.pool.ntp.org iburst', ]
        } else {
          $servers_real = $ntp::servers
        }
      }
      centos, redhat, oel, linux: {
        $supported  = true
        $pkg_name   = [ 'ntp' ]
        $svc_name   = 'ntpd'
        $config     = '/etc/ntp.conf'
        $config_tpl = 'ntp.conf.el.erb'
        if ($ntp::servers == 'UNSET') {
          $servers_real = [ '0.centos.pool.ntp.org',
                            '1.centos.pool.ntp.org',
                            '2.centos.pool.ntp.org', ]
        } else {
          $servers_real = $ntp::servers
        }
      }
      default: {
        $supported = false
        notify { "${module_name}_unsupported":
          message => "The ${module_name} module is not supported on ${::operatingsystem}",
        }
      }
    }
  }
}
