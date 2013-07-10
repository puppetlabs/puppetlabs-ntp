class ntp::install (
  $package_ensure = $ntp::package_ensure,
  $package_name   = $ntp::package_name,
) inherits ntp {

  package { 'ntp':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
