#
class ntp::install inherits ntp {

  if $package_manage {

    package { $package_name:
      ensure => $package_ensure,
    }

  }

}
