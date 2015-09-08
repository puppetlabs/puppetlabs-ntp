#
class ntp::config inherits ntp {

  if $ntp::keys_enable {
    $directory = dirname($ntp::keys_file)
    case $directory {
      '/', '/etc': {}
      default: {
        file { $directory:
          ensure => directory,
          owner  => 0,
          group  => 0,
          mode   => '0755',
        }
      }
    }
  }

  file { $ntp::config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
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
