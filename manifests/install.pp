class ntp::install(
  $ensure_package = $ntp::ensure_package,
  $package_name   = $ntp::package_name,
) {

  package { 'ntp':
    ensure => $ensure_package,
    name   => $package_name,
  }

}
