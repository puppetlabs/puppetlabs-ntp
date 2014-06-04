class ntp::params {

  $autoupdate        = false
  $config_template   = 'ntp/ntp.conf.erb'
  $disable_monitor   = false
  $keys_enable       = false
  $keys_controlkey   = ''
  $keys_requestkey   = ''
  $keys_trusted      = []
  $package_ensure    = 'present'
  $preferred_servers = []
  $service_enable    = true
  $service_ensure    = 'running'
  $service_manage    = true
  $udlc              = false

  # On virtual machines allow large clock skews.
  $panic = str2bool($::is_virtual) ? {
    true    => false,
    default => true,
  }

  $default_config       = '/etc/ntp.conf'
  $default_keys_file    = '/etc/ntp/keys'
  $default_driftfile    = '/var/lib/ntp/drift'
  $default_package_name = ['ntp']
  $default_service_name = 'ntpd'
  $default_restrict     = [
    'default kod nomodify notrap nopeer noquery',
    '-6 default kod nomodify notrap nopeer noquery',
    '127.0.0.1',
    '-6 ::1',
  ]

  case $::osfamily {
    'AIX': {
      $os_keys_file     = '/etc/ntp.keys'
      $os_driftfile     = '/etc/ntp.drift'
      $os_package_name  = [ 'bos.net.tcp.client' ]
      $os_restrict      = [
        'default nomodify notrap nopeer noquery',
        '127.0.0.1',
      ]
      $os_service_name  = 'xntpd'
      $os_servers       = [
        '0.debian.pool.ntp.org iburst',
        '1.debian.pool.ntp.org iburst',
        '2.debian.pool.ntp.org iburst',
        '3.debian.pool.ntp.org iburst',
      ]
    }
    'Debian': {
      $os_service_name    = 'ntp'
      $os_servers         = [
        '0.debian.pool.ntp.org iburst',
        '1.debian.pool.ntp.org iburst',
        '2.debian.pool.ntp.org iburst',
        '3.debian.pool.ntp.org iburst',
      ]
    }
    'RedHat': {
      $os_servers         = [
        '0.centos.pool.ntp.org',
        '1.centos.pool.ntp.org',
        '2.centos.pool.ntp.org',
      ]
    }
    'SuSE': {
      $os_driftfile       = '/var/lib/ntp/drift/ntp.drift'
      $os_service_name    = 'ntp'
      $os_servers         = [
        '0.opensuse.pool.ntp.org',
        '1.opensuse.pool.ntp.org',
        '2.opensuse.pool.ntp.org',
        '3.opensuse.pool.ntp.org',
      ]
    }
    'FreeBSD': {
      $os_driftfile       = '/var/db/ntpd.drift'
      $os_package_name    = ['net/ntp']
      $os_servers         = [
        '0.freebsd.pool.ntp.org iburst maxpoll 9',
        '1.freebsd.pool.ntp.org iburst maxpoll 9',
        '2.freebsd.pool.ntp.org iburst maxpoll 9',
        '3.freebsd.pool.ntp.org iburst maxpoll 9',
      ]
    }
    'Archlinux': {
      $os_servers = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
      ]
    }
    # Gentoo was added as its own $::osfamily in Facter 1.7.0
    'Gentoo': {
      $os_package_name  = ['net-misc/ntp']
      $os_servers       = [
        '0.gentoo.pool.ntp.org',
        '1.gentoo.pool.ntp.org',
        '2.gentoo.pool.ntp.org',
        '3.gentoo.pool.ntp.org',
      ]
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      # Before Facter 1.7.0 Gentoo did not have its own $::osfamily
      case $::operatingsystem {
        'Gentoo': {
          $os_package_name  = ['net-misc/ntp']
          $os_restrict      = [
            'default kod nomodify notrap nopeer noquery',
            '-6 default kod nomodify notrap nopeer noquery',
            '127.0.0.1',
            '-6 ::1',
          ]
          $os_servers         = [
            '0.gentoo.pool.ntp.org',
            '1.gentoo.pool.ntp.org',
            '2.gentoo.pool.ntp.org',
            '3.gentoo.pool.ntp.org',
          ]
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  $config       = pick($os_config,        $default_config)
  $keys_file    = pick($os_keys_file,     $default_keys_file)
  $driftfile    = pick($os_driftfile,     $default_driftfile)
  $package_name = pick($os_package_name,  $default_package_name)
  $service_name = pick($os_service_name,  $default_service_name)
  $restrict     = pick($os_restrict,      $default_restrict)
  $servers      = pick($os_servers,       [''])
}
