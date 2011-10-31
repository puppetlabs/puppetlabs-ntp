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
class ntp($servers="UNSET",
          $ensure="running",
          $autoupdate=false
) {
  include ntp::params
  if ! ($ensure in [ "running", "stopped" ]) {
    fail("ensure parameter must be running or stopped")
  }

  if $autoupdate == true {
    $package_ensure = latest
  } elsif $autoupdate == false {
    $package_ensure = present
  } else {
    fail("autoupdate parameter must be true or false")
  }

  if ($servers == "UNSET") {
    $servers_real = $ntp::params::servers_default
  }

  if ($ntp::params::supported == true) {

    package { 'ntp':
      name   => $ntp::params::pkg_name,
      ensure => $package_ensure,
    }

    file { $ntp::params::config:
      ensure => file,
      owner  => 0,
      group  => 0,
      mode   => 0644,
      content => template("${module_name}/${ntp::params::config_tpl}"),
      require => Package['ntp'],
    }

    service { "ntp":
      ensure     => $ensure,
      name       => $ntp::params::svc_name,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => [ Package['ntp'], File[$ntp::params::config] ],
    }

  }

}
