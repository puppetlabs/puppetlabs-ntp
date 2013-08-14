#
class ntp::install {

  package { 'ntp':
    ensure => $ntp::package_ensure,
    name   => $ntp::package_name,
  }

}
