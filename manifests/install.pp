#
class ntp::install inherits ntp {

  if $package_manage == true {
    package { 'ntp':
      ensure => $package_ensure,
      name   => $package_name,
    }
  }
}
