# @summary
#   This class handles ntp packages.
#
# @api private
#
class ntp::install {
  if $ntp::package_manage {
    if $ntp::sles_legacy_repo_manage and $facts['os']['name'] == 'SLES' and $facts['os']['release']['major'] == '15' {
      # On SLES 15 the ntp package lives in the Legacy module, which is versioned per
      # service pack and architecture (e.g. sle-module-legacy/15.5/aarch64).
      $legacy_module = "sle-module-legacy/${facts['os']['release']['full']}/${facts['os']['architecture']}"

      # The shell provider is used so that a missing SUSEConnect makes the checks
      # fail cleanly instead of erroring; onlyif skips hosts without SUSEConnect or
      # that aren't registered with SCC (no SCCcredentials), where activation can't work.
      exec { 'Enable legacy repos':
        path     => '/bin:/usr/bin:/sbin:/usr/sbin',
        provider => 'shell',
        command  => "SUSEConnect --product ${legacy_module}",
        unless   => "SUSEConnect --status-text | grep -q ${legacy_module}",
        onlyif   => 'test -x /usr/bin/SUSEConnect && test -f /etc/zypp/credentials.d/SCCcredentials',
      }
    }

    package { $ntp::package_name:
      ensure => $ntp::package_ensure,
    }
  }
}
