class ntp (
  Boolean $broadcastclient,
  Stdlib::Absolutepath $config,
  Optional[Stdlib::Absolutepath] $config_dir,
  String $config_file_mode,
  Optional[String] $config_epp,
  Optional[String] $config_template,
  Boolean $disable_auth,
  Boolean $disable_dhclient,
  Boolean $disable_kernel,
  Boolean $disable_monitor,
  Optional[Array[String]] $fudge,
  Stdlib::Absolutepath $driftfile,
  Optional[Stdlib::Absolutepath] $leapfile,
  Optional[Stdlib::Absolutepath] $logfile,
  Boolean $iburst_enable,
  Array[String] $keys,
  Boolean $keys_enable,
  Stdlib::Absolutepath $keys_file,
  Optional[Ntp::Key_id] $keys_controlkey,
  Optional[Ntp::Key_id] $keys_requestkey,
  Optional[Array[Ntp::Key_id]] $keys_trusted,
  Optional[Ntp::Poll_interval] $minpoll,
  Optional[Ntp::Poll_interval] $maxpoll,
  String $package_ensure,
  Boolean $package_manage,
  Array[String] $package_name,
  Optional[Integer[0]] $panic,
  Array[String] $peers,
  Array[String] $preferred_servers,
  Array[String] $restrict,
  Array[String] $interfaces,
  Array[String] $interfaces_ignore,
  Array[String] $servers,
  Boolean $service_enable,
  String $service_ensure,
  Boolean $service_manage,
  String $service_name,
  Optional[String] $service_provider,
  Optional[Integer[0, 65535]] $stepout,
  Optional[Stdlib::Absolutepath] $step_tickers_file,
  Optional[String] $step_tickers_epp,
  Optional[String] $step_tickers_template,
  Optional[Boolean] $tinker,
  Boolean $tos,
  Optional[Integer[1]] $tos_minclock,
  Optional[Integer[1]] $tos_minsane,
  Optional[Integer[1]] $tos_floor,
  Optional[Integer[1]] $tos_ceiling,
  Variant[Boolean, Integer[0,1]] $tos_cohort,
  Boolean $udlc,
  Optional[Integer[1,15]] $udlc_stratum,
  Optional[Stdlib::Absolutepath] $ntpsigndsocket,
  Optional[String] $authprov,
) {
  # defaults for tinker and panic are different, when running on virtual machines
  if str2bool($facts['is_virtual']) {
    $_tinker = pick($tinker, true)
    $_panic  = pick($panic, 0)
  } else {
    $_tinker = pick($tinker, false)
    $_panic  = $panic
  }

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues

  contain ntp::install
  contain ntp::config
  contain ntp::service

  Class['::ntp::install'] ->
  Class['::ntp::config'] ~>
  Class['::ntp::service']
}
