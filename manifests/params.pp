class ntp::params {

  $autoupdate        = false
  $config_template   = 'ntp/ntp.conf.erb'
  $disable_monitor   = false
  $keys_enable       = false
  $keys_controlkey   = ''
  $keys_requestkey   = ''
  $keys_trusted      = []
  $logfile           = undef
  $minpoll           = undef
  $leapfile          = undef
  $package_ensure    = 'present'
  $peers             = []
  $preferred_servers = []
  $service_enable    = true
  $service_ensure    = 'running'
  $service_manage    = true
  $stepout           = undef
  $udlc              = false
  $udlc_stratum      = '10'
  $interfaces        = []
  $disable_auth      = false
  $broadcastclient   = false

  # Allow a list of fudge options
  $fudge             = []

  $default_config       = '/etc/ntp.conf'
  $default_keys_file    = '/etc/ntp/keys'
  $default_driftfile    = '/var/lib/ntp/drift'
  $default_package_name = ['ntp']
  $default_service_name = 'ntpd'

  $package_manage = $::osfamily ? {
    'FreeBSD' => false,
    default   => true,
  }

  if str2bool($::is_virtual) {
    $tinker = true
    $panic  = 0
  }
  else {
    $tinker = false
    $panic  = undef
  }

  case $::osfamily {
    'AIX': {
      $config        = $default_config
      $keys_file     = '/etc/ntp.keys'
      $driftfile     = '/etc/ntp.drift'
      $package_name  = [ 'bos.net.tcp.client' ]
      $restrict      = [
        'default nomodify notrap nopeer noquery',
        '127.0.0.1',
      ]
      $service_name  = 'xntpd'
      $iburst_enable = true
      $servers       = [
        '0.debian.pool.ntp.org',
        '1.debian.pool.ntp.org',
        '2.debian.pool.ntp.org',
        '3.debian.pool.ntp.org',
      ]
      $maxpoll       = undef
    }
    'Debian': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = $default_package_name
      $restrict        = [
        '-4 kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '::1',
      ]
      $service_name    = 'ntp'
      $iburst_enable   = true
      $servers         = [
        '0.debian.pool.ntp.org',
        '1.debian.pool.ntp.org',
        '2.debian.pool.ntp.org',
        '3.debian.pool.ntp.org',
      ]
      $maxpoll         = undef
    }
    'RedHat': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = $default_package_name
      $service_name    = $default_service_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $iburst_enable   = false
      $servers         = [
        '0.centos.pool.ntp.org',
        '1.centos.pool.ntp.org',
        '2.centos.pool.ntp.org',
      ]
      $maxpoll         = undef
    }
    'Suse': {
      if $::operatingsystem == 'SLES' and $::operatingsystemmajrelease == '12'
      {
        $service_name  = 'ntpd'
        $keys_file     = '/etc/ntp.keys'
      } else{
        $service_name  = 'ntp'
        $keys_file     = $default_keys_file
      }
      $config          = $default_config
      $driftfile       = '/var/lib/ntp/drift/ntp.drift'
      $package_name    = $default_package_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $iburst_enable   = false
      $servers         = [
        '0.opensuse.pool.ntp.org',
        '1.opensuse.pool.ntp.org',
        '2.opensuse.pool.ntp.org',
        '3.opensuse.pool.ntp.org',
      ]
      $maxpoll         = undef
    }
    'FreeBSD': {
      $config          = $default_config
      $driftfile       = '/var/db/ntpd.drift'
      $keys_file       = $default_keys_file
      $package_name    = ['net/ntp']
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name    = $default_service_name
      $iburst_enable   = true
      $servers         = [
        '0.freebsd.pool.ntp.org',
        '1.freebsd.pool.ntp.org',
        '2.freebsd.pool.ntp.org',
        '3.freebsd.pool.ntp.org',
      ]
      $maxpoll         = 9
    }
    'Archlinux': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = $default_package_name
      $service_name    = $default_service_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $iburst_enable   = false
      $servers         = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
      ]
      $maxpoll         = undef
    }
    'Solaris': {
      $config        = '/etc/inet/ntp.conf'
      $driftfile     = '/var/ntp/ntp.drift'
      $keys_file     = '/etc/inet/ntp.keys'
      $package_name  = $::operatingsystemrelease ? {
        /^(5\.10|10|10_u\d+)$/ => [ 'SUNWntpr', 'SUNWntpu' ],
        /^(5\.11|11|11\.\d+)$/ => [ 'service/network/ntp' ]
      }
      $restrict      = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $service_name  = 'network/ntp'
      $iburst_enable = false
      $servers       = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
        '3.pool.ntp.org',
      ]
      $maxpoll       = undef
    }
  # Gentoo was added as its own $::osfamily in Facter 1.7.0
    'Gentoo': {
      $config          = $default_config
      $keys_file       = $default_keys_file
      $driftfile       = $default_driftfile
      $package_name    = ['net-misc/ntp']
      $service_name    = $default_service_name
      $restrict        = [
        'default kod nomodify notrap nopeer noquery',
        '-6 default kod nomodify notrap nopeer noquery',
        '127.0.0.1',
        '-6 ::1',
      ]
      $iburst_enable   = false
      $servers         = [
        '0.gentoo.pool.ntp.org',
        '1.gentoo.pool.ntp.org',
        '2.gentoo.pool.ntp.org',
        '3.gentoo.pool.ntp.org',
      ]
      $maxpoll         = undef
    }
    'Linux': {
    # Account for distributions that don't have $::osfamily specific settings.
    # Before Facter 1.7.0 Gentoo did not have its own $::osfamily
      case $::operatingsystem {
        'Gentoo': {
          $config          = $default_config
          $keys_file       = $default_keys_file
          $driftfile       = $default_driftfile
          $service_name    = $default_service_name
          $package_name    = ['net-misc/ntp']
          $restrict        = [
            'default kod nomodify notrap nopeer noquery',
            '-6 default kod nomodify notrap nopeer noquery',
            '127.0.0.1',
            '-6 ::1',
          ]
          $iburst_enable   = false
          $servers         = [
            '0.gentoo.pool.ntp.org',
            '1.gentoo.pool.ntp.org',
            '2.gentoo.pool.ntp.org',
            '3.gentoo.pool.ntp.org',
          ]
          $maxpoll         = undef
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
}
