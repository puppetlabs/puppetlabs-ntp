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
#    - FreeBSD 9.0
#    - Archlinux
#
# Parameters:
#
#   $servers = [ '0.debian.pool.ntp.org iburst',
#                '1.debian.pool.ntp.org iburst',
#                '2.debian.pool.ntp.org iburst',
#                '3.debian.pool.ntp.org iburst', ]
#
#   $restrict = true
#     Whether to restrict ntp daemons from allowing others to use as a server.
#
#   $autoupdate = false
#     Whether to update the ntp package automatically or not.
#
#   $enable = true
#     Automatically start ntp deamon on boot.
#
#   $template = '${module_name}/${config_tpl}'
#     Override with your own explicit template.
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
          $enable=true,
          $restrict=true,
          $config_template=undef,
          $autoupdate=false,
          $servers = undef
) {

  include ::ntp::params

  if ! ($ensure in [ 'running', 'stopped' ]) {
    fail('ensure parameter must be running or stopped')
  }

  if $autoupdate == true {
    $package_ensure = latest
  } elsif $autoupdate == false {
    $package_ensure = present
  } else {
    fail('autoupdate parameter must be true or false')
  }

  if undef == $servers { $servers = $::ntp::params::servers }

  if ($config_template == undef) {
    $template_real = "${module_name}/${::ntp::params::config_template}"
  } else {
    $template_real = $config_template
  }

  package { $::ntp::params::package:
    ensure => $package_ensure,
    name   => $::ntp::params::package,
  }

  file { $::ntp::params::config_file:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($template_real),
    require => Package[$::ntp::param::package],
  }

  service { $::ntp::params::service:
    ensure     => $ensure,
    enable     => $enable,
    name       => $::ntp::params::service,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => [ Package[$::ntp::params::package], File[$::ntp::params::config_file] ],
  }
}
