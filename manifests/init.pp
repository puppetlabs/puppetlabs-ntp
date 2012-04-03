# Class: ntp
#
#   This module manages the ntp service.
#
#   Jeff McCune <jeff@puppetlabs.com>
#   2011-02-23
#
#   Tested platforms:
#    - Debian 6.0 Squeeze
#    - CentOS 5.4
#    - Amazon Linux 2011.09
#
# Parameters:
#
#   $servers = [ "0.debian.pool.ntp.org iburst",
#                "1.debian.pool.ntp.org iburst",
#                "2.debian.pool.ntp.org iburst",
#                "3.debian.pool.ntp.org iburst", ]
#
# Actions:
#
#  Installs, configures, and manages the ntp service.
#
# Requires:
#
# Sample Usage:
#
#   class { "ntp":
#     servers    => [ 'time.apple.com' ],
#     autoupdate => false,
#   }
#
# [Remember: No empty lines between comments and class definition]
class ntp($servers='UNSET',
          $ensure='running',
          $version='present',
) {
  class { 'ntp::params': hiera_enabled => $::hiera_enabled }

  if ! ($ensure in [ 'running', 'stopped' ]) {
    fail('ensure parameter must be running or stopped')
  }

  if ($ntp::params::supported == true) {

    package { $ntp::params::pkg_name:
      ensure => $version,
    }

    file { $ntp::params::config:
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => template("${module_name}/${ntp::params::config_tpl}"),
      require => Package[$ntp::params::pkg_name],
    }

    service { 'ntp':
      ensure     => $ensure,
      name       => $ntp::params::svc_name,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => [ Package[$ntp::params::pkg_name],
                      File[$ntp::params::config] ],
    }

  }

}
