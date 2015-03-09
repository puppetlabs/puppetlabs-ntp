#
class ntp::config inherits ntp {

  if $keys_enable {
    file { $keys_file:
      ensure => file,
      owner  => 0,
      group  => 0,
      mode   => '0644',
    }
  }

  if $config_dir {
    file { $config_dir:
      ensure  => directory,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      recurse => false,
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
