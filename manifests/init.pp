class ntp (
  $autoupdate,
  Stdlib::Compat::Bool $broadcastclient,
  Stdlib::Compat::Absolute_path $config,
  Variant[Any, Undef, Stdlib::Compat::Absolute_path] $config_dir,
  $config_file_mode,
  Stdlib::Compat::String $config_template,
  Stdlib::Compat::Bool $disable_auth,
  Stdlib::Compat::Bool $disable_dhclient,
  Stdlib::Compat::Bool $disable_kernel,
  Stdlib::Compat::Bool $disable_monitor,
  Stdlib::Compat::Array $fudge,
  Stdlib::Compat::Absolute_path $driftfile,
  Variant[Boolean, Undef, Stdlib::Compat::Absolute_path] $leapfile,
  Variant[Boolean, Undef, Stdlib::Compat::Absolute_path] $logfile,
  Stdlib::Compat::Bool $iburst_enable,
  Stdlib::Compat::Array $keys,
  Stdlib::Compat::Bool $keys_enable,
  $keys_file,
  Variant[Pattern['^\d+$'], Pattern['']] $keys_controlkey,
  Variant[Pattern['^\d+$'], Pattern['']] $keys_requestkey,
  Stdlib::Compat::Array $keys_trusted,
  Variant[Boolean, Undef, Stdlib::Compat::Numeric] $minpoll,
  Variant[Boolean, Undef, Stdlib::Compat::Numeric] $maxpoll,
  Stdlib::Compat::String $package_ensure,
  Stdlib::Compat::Bool $package_manage,
  Stdlib::Compat::Array $package_name,
  Variant[Optional[Integer], Stdlib::Compat::Numeric] $panic,
  Stdlib::Compat::Array $peers,
  Stdlib::Compat::Array $preferred_servers,
  Stdlib::Compat::Array $restrict,
  Stdlib::Compat::Array $interfaces,
  $interfaces_ignore,
  Stdlib::Compat::Array $servers,
  Stdlib::Compat::Bool $service_enable,
  Stdlib::Compat::String $service_ensure,
  Stdlib::Compat::Bool $service_manage,
  Stdlib::Compat::String $service_name,
  Variant[Optional[String], Any] $service_provider,
  Variant[Boolean, Undef, Stdlib::Compat::Numeric] $stepout,
  Variant[Boolean, Undef, Stdlib::Compat::String] $step_tickers_file,
  Variant[Any, Undef, Stdlib::Compat::String] $step_tickers_template,
  Optional[Stdlib::Compat::Bool] $tinker,
  Stdlib::Compat::Bool $tos,
  Variant[Boolean, Undef, Stdlib::Compat::Numeric] $tos_minclock,
  Variant[Boolean, Undef, Stdlib::Compat::Numeric] $tos_minsane,
  Variant[Boolean, Undef, Stdlib::Compat::Numeric] $tos_floor,
  Variant[Boolean, Undef, Stdlib::Compat::Numeric] $tos_ceiling,
  Variant[Boolean, Undef, Pattern['^[0|1]$']] $tos_cohort,
  Stdlib::Compat::Bool $udlc,
  $udlc_stratum,
  Variant[Boolean, Undef, Stdlib::Compat::Absolute_path] $ntpsigndsocket,
  Variant[Any, Undef, Stdlib::Compat::String] $authprov,
) {

  validate_bool($broadcastclient)
  validate_absolute_path($config)
  validate_string($config_template)
  validate_bool($disable_auth)
  validate_bool($disable_dhclient)
  validate_bool($disable_kernel)
  validate_bool($disable_monitor)
  validate_absolute_path($driftfile)
  if $logfile { validate_absolute_path($logfile) }
  if $ntpsigndsocket { validate_absolute_path($ntpsigndsocket) }
  if $leapfile { validate_absolute_path($leapfile) }
  validate_bool($iburst_enable)
  validate_array($keys)
  validate_bool($keys_enable)
  validate_re($keys_controlkey, ['^\d+$', ''])
  validate_re($keys_requestkey, ['^\d+$', ''])
  validate_array($keys_trusted)
  if $minpoll { validate_numeric($minpoll, 16, 3) }
  if $maxpoll { validate_numeric($maxpoll, 16, 3) }
  validate_string($package_ensure)
  validate_bool($package_manage)
  validate_array($package_name)
  validate_array($preferred_servers)
  validate_array($restrict)
  validate_array($interfaces)
  validate_array($servers)
  validate_array($fudge)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  if $stepout { validate_numeric($stepout, 65535, 0) }
  if $step_tickers_file {
    validate_string($step_tickers_file)
    validate_string($step_tickers_template)
  }
  validate_bool($tos)
  if $tos_minclock { validate_numeric($tos_minclock) }
  if $tos_minsane { validate_numeric($tos_minsane) }
  if $tos_floor { validate_numeric($tos_floor) }
  if $tos_ceiling { validate_numeric($tos_ceiling) }
  if $tos_cohort { validate_re($tos_cohort, '^[0|1]$', "Must be 0 or 1, got: ${tos_cohort}") }
  validate_bool($udlc)
  validate_array($peers)
  if $authprov { validate_string($authprov) }

  if $config_dir {
    validate_absolute_path($config_dir)
  }

  if $autoupdate {
    notice('ntp: autoupdate parameter has been deprecated and replaced with package_ensure. Set package_ensure to latest for the same behavior as autoupdate => true.')
  }

  # defaults for tinker and panic are different, when running on virtual machines
  if str2bool($::is_virtual) {
    $_tinker = pick($tinker, true)
    $_panic  = pick($panic, 0)
  } else {
    $_tinker = pick($tinker, false)
    $_panic  = $panic
  }

  validate_bool($_tinker)
  if $_panic != undef { validate_numeric($_panic, 65535, 0) }


  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': } ->
  class { '::ntp::install': } ->
  class { '::ntp::config': } ~>
  class { '::ntp::service': } ->
  anchor { 'ntp::end': }

}
