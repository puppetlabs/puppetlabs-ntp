#
class ntp::config {

  $config            = $ntp::config
  $config_template   = $ntp::config_template
  $driftfile         = $ntp::driftfile
  $keys_enable       = $ntp::keys_enable
  $keys_file         = $ntp::keys_file
  $keys_controlkey   = $ntp::keys_controlkey
  $keys_requestkey   = $ntp::keys_requestkey
  $keys_trusted      = $ntp::keys_trusted
  $panic             = $ntp::panic
  $preferred_servers = $ntp::preferred_servers
  $restrict          = $ntp::restrict
  $servers           = $ntp::servers

  if $keys_enable {
    $directory = dirname($keys_file)
    file { $directory:
      ensure  => directory,
      owner   => 0,
      group   => 0,
      mode    => '0755',
      recurse => true,
    }
  }

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($config_template),
  }

}
