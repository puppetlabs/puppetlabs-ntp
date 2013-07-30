#
class ntp::service {

  $service_enable = $ntp::service_enable
  $service_ensure = $ntp::service_ensure
  $service_manage = $ntp::service_manage
  $service_name   = $ntp::service_name

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { 'ntp':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
