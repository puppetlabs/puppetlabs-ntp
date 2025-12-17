# @summary
#   This class handles ntp packages.
#
# @api private
#
class ntp::install {
  if $ntp::package_manage {
    if ($facts['os']['name'] == 'SLES' and $facts['os']['release']['major'] == '15') {
      $sles_version = $facts['os']['release']['full']
      exec { 'Enable legacy repos':
        path    => '/bin:/usr/bin/:/sbin:/usr/sbin',
        command => "/usr/bin/SUSEConnect --product sle-module-legacy/${sles_version}/x86_64",
        unless  => "SUSEConnect --status-text | grep 'sle-module-legacy/${sles_version}/x86_64'",
      }
      -> Package[$ntp::package_name]
    }

    package { $ntp::package_name:
      ensure => $ntp::package_ensure,
    }
  }
}
