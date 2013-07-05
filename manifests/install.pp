class ntp::install(
  $autoupdate   = $ntp::autoupdate,
  $package_name = $ntp::package_name,
) {

  validate_bool($autoupdate)

  $package_ensure = $autoupdate ? {
    true    => 'latest',
    default => 'present',
  }

  package { 'ntp':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
