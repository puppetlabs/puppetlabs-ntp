class ntp (
  $autoupdate,
  $broadcastclient,
  $config,
  $config_dir,
  $config_file_mode,
  $config_template,
  $disable_auth,
  $disable_dhclient,
  $disable_kernel,
  $disable_monitor,
  $fudge,
  $driftfile,
  $leapfile,
  $logfile,
  $iburst_enable,
  $keys,
  $keys_enable,
  $keys_file,
  $keys_controlkey,
  $keys_requestkey,
  $keys_trusted,
  $minpoll,
  $maxpoll,
  $package_ensure,
  $package_manage,
  $package_name,
  $panic,
  $peers,
  $preferred_servers,
  $restrict,
  $interfaces,
  $interfaces_ignore,
  $servers,
  $service_enable,
  $service_ensure,
  $service_manage,
  $service_name,
  $service_provider,
  $stepout,
  $step_tickers_file,
  $step_tickers_template,
  $tinker,
  $tos,
  $tos_minclock,
  $tos_minsane,
  $tos_floor,
  $tos_ceiling,
  $tos_cohort,
  $udlc,
  $udlc_stratum,
  $ntpsigndsocket,
  $authprov,
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
