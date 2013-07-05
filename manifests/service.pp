class ntp::service (
  $ensure_service = $ntp::ensure_service,
  $enable_service = $ntp::enable_service,
  $service_name   = $ntp::service_name,
) {

  if ! ($ensure_service in [ 'running', 'stopped' ]) {
    fail('ensure_service parameter must be running or stopped')
  }
  validate_bool($enable_service)

  service { 'ntp':
    ensure     => $ensure_service,
    enable     => $enable_service,
    name       => $service_name,
    hasstatus  => true,
    hasrestart => true,
  }

}
