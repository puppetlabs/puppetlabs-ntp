class ntp (
  Any $autoupdate,
  Variant[Boolean, Stdlib::Compat::Bool] $broadcastclient,
  Variant[Stdlib::Absolutepath, Stdlib::Compat::Absolute_path] $config,
  Variant[Optional[Stdlib::Absolutepath], Any, Undef, Stdlib::Compat::Absolute_path] $config_dir,
  Variant[String, Any] $config_file_mode,
  Optional[String] $config_epp,
  Variant[String[1], Stdlib::Compat::String] $config_template,
  Variant[Boolean, Stdlib::Compat::Bool] $disable_auth,
  Variant[Boolean, Stdlib::Compat::Bool] $disable_dhclient,
  Variant[Boolean, Stdlib::Compat::Bool] $disable_kernel,
  Variant[Boolean, Stdlib::Compat::Bool] $disable_monitor,
  Variant[Optional[Array[String]], Stdlib::Compat::Array] $fudge,
  Variant[Stdlib::Absolutepath, Stdlib::Compat::Absolute_path] $driftfile,
  Variant[Optional[Stdlib::Absolutepath], Boolean, Undef, Stdlib::Compat::Absolute_path] $leapfile,
  Variant[Optional[Stdlib::Absolutepath], Boolean, Undef, Stdlib::Compat::Absolute_path] $logfile,
  Variant[Boolean, Stdlib::Compat::Bool] $iburst_enable,
  Variant[Array[String], Stdlib::Compat::Array] $keys,
  Variant[Boolean, Stdlib::Compat::Bool] $keys_enable,
  Variant[Stdlib::Absolutepath, Any] $keys_file,
  Variant[Optional[Ntp::Key_id], Pattern['^\d+$'], Pattern['']] $keys_controlkey,
  Variant[Optional[Ntp::Key_id], Pattern['^\d+$'], Pattern['']] $keys_requestkey,
  Variant[Optional[Array[Ntp::Key_id]], Stdlib::Compat::Array] $keys_trusted,
  Variant[Optional[Ntp::Poll_interval], Boolean, Undef, Stdlib::Compat::Numeric] $minpoll,
  Variant[Optional[Ntp::Poll_interval], Boolean, Undef, Stdlib::Compat::Numeric] $maxpoll,
  Variant[String, Stdlib::Compat::String] $package_ensure,
  Variant[Boolean, Stdlib::Compat::Bool] $package_manage,
  Variant[Array[String], Stdlib::Compat::Array] $package_name,
  Variant[Optional[Integer[0]], Undef, Stdlib::Compat::Numeric] $panic,
  Variant[Array[String], Stdlib::Compat::Array] $peers,
  Variant[Array[String], Stdlib::Compat::Array] $preferred_servers,
  Variant[Array[String], Stdlib::Compat::Array] $restrict,
  Variant[Array[String], Stdlib::Compat::Array] $interfaces,
  Variant[Array[String], Any] $interfaces_ignore,
  Variant[Array[String], Stdlib::Compat::Array] $servers,
  Variant[Boolean, Stdlib::Compat::Bool] $service_enable,
  Variant[String, Stdlib::Compat::String] $service_ensure,
  Variant[Boolean, Stdlib::Compat::Bool] $service_manage,
  Variant[String, Stdlib::Compat::String] $service_name,
  Variant[String, Any] $service_provider,
  Variant[Optional[Integer[0, 65535]], Boolean, Undef, Stdlib::Compat::Numeric] $stepout,
  Variant[Optional[Stdlib::Absolutepath], Boolean, Undef, Stdlib::Compat::String] $step_tickers_file,
  Optional[String] $step_tickers_epp,
  Variant[Optional[String], Any, Undef, Stdlib::Compat::String] $step_tickers_template,
  Variant[Optional[Boolean], Optional[Stdlib::Compat::Bool]] $tinker,
  Variant[Boolean, Stdlib::Compat::Bool] $tos,
  Variant[Optional[Integer[1]], Boolean, Undef, Stdlib::Compat::Numeric] $tos_minclock,
  Variant[Optional[Integer[1]], Boolean, Undef, Stdlib::Compat::Numeric] $tos_minsane,
  Variant[Optional[Integer[1]], Boolean, Undef, Stdlib::Compat::Numeric] $tos_floor,
  Variant[Optional[Integer[1]], Boolean, Undef, Stdlib::Compat::Numeric] $tos_ceiling,
  Variant[Variant[Boolean, Integer[0,1]], Boolean, Undef, Pattern['^[0|1]$']] $tos_cohort,
  Variant[Boolean, Stdlib::Compat::Bool] $udlc,
  Variant[Optional[Integer[1,15]], Any] $udlc_stratum,
  Variant[Optional[Stdlib::Absolutepath], Boolean, Undef, Stdlib::Compat::Absolute_path] $ntpsigndsocket,
  Variant[Optional[String], Any, Undef, Stdlib::Compat::String] $authprov,
) {

  validate_legacy(Boolean, 'validate_bool', $broadcastclient)
  validate_legacy(Stdlib::Absolutepath, 'validate_absolute_path', $config)

  assert_type(String, $config_file_mode) |$expected, $actual| {
    deprecation("ntp::config_file_mode should be '${expected}', not '${actual}'")
  }

  validate_legacy(String[1], 'validate_string', $config_template)
  validate_legacy(Boolean, 'validate_bool', $disable_auth)
  validate_legacy(Boolean, 'validate_bool', $disable_dhclient)
  validate_legacy(Boolean, 'validate_bool', $disable_kernel)
  validate_legacy(Boolean, 'validate_bool', $disable_monitor)
  validate_legacy(Stdlib::Absolutepath, 'validate_absolute_path', $driftfile)

  if $logfile { validate_legacy(Optional[Stdlib::Absolutepath], 'validate_absolute_path', $logfile) }
  elsif $logfile == undef { }
  else { deprecation('ntp::logfile is false, but should be undef') }

  if $ntpsigndsocket { validate_legacy(Optional[Stdlib::Absolutepath], 'validate_absolute_path', $ntpsigndsocket) }
  elsif $ntpsigndsocket == undef { }
  else { deprecation('ntp::ntpsigndsocket is false, but should be undef') }

  if $leapfile { validate_legacy(Optional[Stdlib::Absolutepath], 'validate_absolute_path', $leapfile) }
  elsif $leapfile == undef { }
  else { deprecation('ntp::leapfile is false, but should be undef') }

  validate_legacy(Boolean, 'validate_bool', $iburst_enable)
  validate_legacy(Array[String], 'validate_array', $keys)
  validate_legacy(Boolean, 'validate_bool', $keys_enable)
  validate_legacy(Optional[Ntp::Key_id], 'validate_re', $keys_controlkey, ['^\d+$', ''])
  validate_legacy(Optional[Ntp::Key_id], 'validate_re', $keys_requestkey, ['^\d+$', ''])
  validate_legacy(Optional[Array[Ntp::Key_id]], 'validate_array', $keys_trusted)
  if $minpoll { validate_legacy(Optional[Ntp::Poll_interval], 'validate_numeric', $minpoll, 16, 3) }
  elsif $minpoll == undef { }
  else { deprecation('ntp::minpoll is false, but should be undef') }

  if $maxpoll { validate_legacy(Optional[Ntp::Poll_interval], 'validate_numeric', $maxpoll, 16, 3) }
  elsif $maxpoll == undef { }
  else { deprecation('ntp::maxpoll is false, but should be undef') }

  validate_legacy(String, 'validate_string', $package_ensure)
  validate_legacy(Boolean, 'validate_bool', $package_manage)
  validate_legacy(Array[String], 'validate_array', $package_name)

  validate_legacy(Array[String], 'validate_array', $preferred_servers)
  validate_legacy(Array[String], 'validate_array', $restrict)
  validate_legacy(Array[String], 'validate_array', $interfaces)
  assert_type(Array[String], $interfaces_ignore) |$expected, $actual| {
    deprecation("ntp::interfaces_ignore should be '${expected}', not '${actual}'")
  }
  validate_legacy(Array[String], 'validate_array', $servers)
  validate_legacy(Array[String], 'validate_array', $fudge)
  validate_legacy(Boolean, 'validate_bool', $service_enable)
  validate_legacy(String, 'validate_string', $service_ensure)
  validate_legacy(Boolean, 'validate_bool', $service_manage)
  validate_legacy(String, 'validate_string', $service_name)
  assert_type(String, $service_provider) |$expected, $actual| {
    deprecation('puppet_3_type_check', "ntp::service_provider should be '${expected}', not '${actual}'")
  }

  if $stepout { validate_legacy(Optional[Integer[0, 65535]], 'validate_numeric', $stepout, 65535, 0) }
  elsif $stepout == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::stepout is false, but should be undef') }

  if $step_tickers_file {
    validate_legacy(Optional[Stdlib::Absolutepath], 'validate_string', $step_tickers_file)
    validate_legacy(Optional[String], 'validate_string', $step_tickers_template)
  }
  elsif $step_tickers_file == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::step_tickers_file is false, but should be undef') }

  # In cases where $step_tickers_file evaluated to false, anything could have been
  # passed to $step_tickers_template. This deprecation removes that hole.
  assert_type(Optional[String], $step_tickers_template) |$expected, $actual| {
    deprecation('puppet_3_type_check', "ntp::step_tickers_template should be '${expected}', not '${actual}'")
  }

  validate_legacy(Boolean, 'validate_bool', $tos)
  if $tos_minclock { validate_legacy(Optional[Integer[1]], 'validate_numeric', $tos_minclock) }
  elsif $tos_minclock == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::tos_minclock is false, but should be undef') }

  if $tos_minsane { validate_legacy(Optional[Integer[1]], 'validate_numeric', $tos_minsane) }
  elsif $tos_minsane == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::tos_minsane is false, but should be undef') }

  if $tos_floor { validate_legacy(Optional[Integer[1]], 'validate_numeric', $tos_floor) }
  elsif $tos_floor == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::tos_floor is false, but should be undef') }

  if $tos_ceiling { validate_legacy(Optional[Integer[1]], 'validate_numeric', $tos_ceiling) }
  elsif $tos_ceiling == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::tos_ceiling is false, but should be undef') }

  if $tos_cohort { validate_legacy(Variant[Boolean, Integer[0,1]], 'validate_re', $tos_cohort, '^[0|1]$', "Must be 0 or 1, got: ${tos_cohort}") }
  elsif $tos_cohort == undef { }
  elsif $tos_cohort == false { }
  else {
    # No idea what else could come through here, but better safe than sorry, and
    # with the next major release, this will go away, anyways.
    assert_type(Optional[Variant[Boolean, Integer[0,1]]], $tos_cohort) |$expected, $actual| {
      deprecation('puppet_3_type_check', "ntp::tos_cohort should be '${expected}', not '${actual}'")
    }
  }

  validate_legacy(Boolean, 'validate_bool', $udlc)
  assert_type(Optional[Integer[1,15]], $udlc_stratum) |$expected, $actual| {
    deprecation('puppet_3_type_check', "ntp::udlc_stratum should be '${expected}', not '${actual}'")
  }

  validate_legacy(Array[String], 'validate_array', $peers)
  if $authprov { validate_legacy(Optional[String], 'validate_string', $authprov) }
  elsif $authprov == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::authprov is false, but should be undef') }


  if $config_dir { validate_legacy(Optional[Stdlib::Absolutepath], 'validate_absolute_path', $config_dir) }
  elsif $config_dir == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::config_dir is false, but should be undef') }


  if $autoupdate {
    deprecation('ntp::autoupdate', 'ntp: autoupdate parameter has been deprecated and replaced with package_ensure. Set package_ensure to latest for the same behavior as autoupdate => true.')
  }

  # defaults for tinker and panic are different, when running on virtual machines
  if str2bool($facts['is_virtual']) {
    $_tinker = pick($tinker, true)
    $_panic  = pick($panic, 0)
  } else {
    $_tinker = pick($tinker, false)
    $_panic  = $panic
  }

  validate_legacy(Boolean, 'validate_bool', $_tinker)
  if $_panic { validate_legacy(Optional[Integer[0]], 'validate_numeric', $_panic, 65535, 0) }
  elsif $_panic == undef { }
  else { deprecation('puppet_3_type_check', 'ntp::panic is false, but should be undef') }

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': } ->
  class { '::ntp::install': } ->
  class { '::ntp::config': } ~>
  class { '::ntp::service': } ->
  anchor { 'ntp::end': }

}
