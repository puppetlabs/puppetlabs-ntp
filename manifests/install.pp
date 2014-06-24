#
class ntp::install inherits ntp {

  package { $package_name:
    ensure => $package_ensure,
  }

}
