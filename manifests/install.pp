# @api private
# This class handles ntp packages. Avoid modifying private classes.
class ntp::install {

  if $ntp::package_manage {

    package { $ntp::package_name:
      ensure => $ntp::package_ensure,
    }

  }

}
