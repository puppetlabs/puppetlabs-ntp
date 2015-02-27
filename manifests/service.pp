#
class ntp::service inherits ntp {

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

  $use_servers = join($servers, " ")
  if $autosync {
    exec { "/usr/sbin/ntpdate -u -s ${use_servers}":
      refreshonly => true
    }
  }

}
