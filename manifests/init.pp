class ntp (
  $autoupdate        = $ntp::params::autoupdate,
  $config            = $ntp::params::config,
  $config_template   = $ntp::params::config_template,
  $disable_monitor   = $ntp::params::disable_monitor,
  $driftfile         = $ntp::params::driftfile,
  $logfile           = $ntp::params::logfile,
  $keys_enable       = $ntp::params::keys_enable,
  $keys_file         = $ntp::params::keys_file,
  $keys_controlkey   = $ntp::params::keys_controlkey,
  $keys_requestkey   = $ntp::params::keys_requestkey,
  $keys_trusted      = $ntp::params::keys_trusted,
  $package_ensure    = $ntp::params::package_ensure,
  $package_name      = $ntp::params::package_name,
  $panic             = $ntp::params::panic,
  $preferred_servers = $ntp::params::preferred_servers,
  $restrict          = $ntp::params::restrict,
  $interfaces        = $ntp::params::interfaces,
  $servers           = $ntp::params::servers,
  $service_enable    = $ntp::params::service_enable,
  $service_ensure    = $ntp::params::service_ensure,
  $service_manage    = $ntp::params::service_manage,
  $service_name      = $ntp::params::service_name,
  $udlc              = $ntp::params::udlc
) inherits ntp::params {

  validate_absolute_path($config)
  validate_string($config_template)
  validate_bool($disable_monitor)
  validate_absolute_path($driftfile)
  if $logfile { validate_absolute_path($logfile) }
  validate_bool($keys_enable)
  validate_re($keys_controlkey, ['^\d+$', ''])
  validate_re($keys_requestkey, ['^\d+$', ''])
  validate_array($keys_trusted)
  validate_string($package_ensure)
  validate_array($package_name)
  validate_bool($panic)
  validate_array($preferred_servers)
  validate_array($restrict)
  validate_array($interfaces)
  validate_array($servers)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_bool($udlc)

  if $autoupdate {
    notice('autoupdate parameter has been deprecated and replaced with package_ensure.  Set this to latest for the same behavior as autoupdate => true.')
  }
  
  Class["${module_name}::install"] ->
  Class["${module_name}::config"] ~>
  Class["${module_name}::service"]

  class { "${module_name}::install": }
  class { "${module_name}::config": }
  class { "${module_name}::service": }

  contain "${module_name}::install"
  contain "${module_name}::config"
  contain "${module_name}::service"
}
