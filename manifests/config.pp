# Private Class
class ntp::config inherits ntp {

  if $ntp::keys_enable {
    case $ntp::config_dir {
      '/', '/etc', undef: {}
      default: {
        file { $ntp::config_dir:
          ensure  => directory,
          owner   => 0,
          group   => 0,
          mode    => '0664',
          recurse => false,
        }
      }
    }

    file { $ntp::keys_file:
      ensure => file,
      owner  => 0,
      group  => 0,
      mode   => '0664',
    }
  }

  file { $ntp::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => $::ntp::config_file_mode,
    content => template($ntp::config_template),
  }

  if $ntp::logfile {
    file { $ntp::logfile:
      ensure => 'file',
      owner  => 'ntp',
      group  => 'ntp',
      mode   => '0664',
    }
  }

  if $ntp::disable_dhclient {
    augeas { 'disable ntp-servers in dhclient.conf':
      context => '/files/etc/dhcp/dhclient.conf',
      changes => 'rm request/*[.="ntp-servers"]',
    }

    file { '/var/lib/ntp/ntp.conf.dhcp':
      ensure => absent,
    }
  }
}
