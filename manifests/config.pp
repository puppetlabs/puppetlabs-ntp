class ntp::config (
  $config          = $ntp::config,
  $config_template = $ntp::config_template,
  $panic           = $ntp::panic,
  $restrict        = $ntp::restrict,
  $servers         = $ntp::servers,
) inherits ntp {

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }

}
