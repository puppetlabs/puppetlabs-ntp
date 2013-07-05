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
class ntp(
  $autoupdate      = $ntp::params::autoupdate,
  $config          = $ntp::params::config,
  $config_template = $ntp::params::config_template,
  $enable_service  = $ntp::params::enable_service,
  $ensure_service  = $ntp::params::ensure_service,
  $package_name    = $ntp::params::package_name,
  $restrict        = $ntp::params::restrict,
  $servers         = $ntp::params::servers,
  $service_name    = $ntp::params::service_name,
) inherits ntp::params {

  include '::ntp::install'
  include '::ntp::config'
  include '::ntp::service'

  Class['::ntp::install'] -> Class['::ntp::config'] ~> Class['::ntp::service']

}
