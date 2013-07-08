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
  $ensure_package  = $ntp::params::ensure_package,
  $ensure_service  = $ntp::params::ensure_service,
  $manage_service  = $ntp::params::manage_service,
  $package_name    = $ntp::params::package_name,
  $restrict        = $ntp::params::restrict,
  $servers         = $ntp::params::servers,
  $service_name    = $ntp::params::service_name,
) inherits ntp::params {

  if $autoupdate {
    notice('autoupdate parameter has been deprecated and replaced with ensure_package.  Set this to latest for the same behavior as autoupdate => true.')
  }

  include '::ntp::install'
  include '::ntp::config'
  include '::ntp::service'

  # Anchor this as per #8140 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': }
  anchor { 'ntp::end': }

  Anchor['ntp::begin'] -> Class['::ntp::install'] -> Class['::ntp::config']
    ~> Class['::ntp::service'] -> Anchor['ntp::end']

}
