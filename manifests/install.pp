# @summary
#   This class handles ntp packages.
#
# @api private
#
class ntp::install {
  if $ntp::package_manage {
    if ($facts['os']['name'] == 'SLES' and $facts['os']['release']['major'] == '15') {
      exec { 'Enable legacy repos':
        path    => '/bin:/usr/bin/:/sbin:/usr/sbin',
        command => '/usr/bin/SUSEConnect --product sle-module-legacy/15.6/x86_64',
        unless  => 'SUSEConnect --status-text | grep sle-module-legacy/15.6/x86_64',
      }
    }

    package { $ntp::package_name:
      ensure => $ntp::package_ensure,
    }
  }
}
