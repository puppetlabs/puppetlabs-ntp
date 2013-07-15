class ntp::params {

  $autoupdate     = false
  $package_ensure = 'present'
  $restrict       = true
  $service_enable = true
  $service_ensure = 'running'
  $service_manage = true

  # On virtual machines allow large clock skews.
  $panic = $::is_virtual ? {
    'true'  => false,
    default => true,
  }

  case $::osfamily {
    'Debian': {
      $config          = '/etc/ntp.conf'
      $config_template = 'ntp/ntp.conf.debian.erb'
      $package_name    = [ 'ntp' ]
      $service_name    = 'ntp'
      $servers         = [
        '0.debian.pool.ntp.org iburst',
        '1.debian.pool.ntp.org iburst',
        '2.debian.pool.ntp.org iburst',
        '3.debian.pool.ntp.org iburst',
      ]
    }
    'RedHat': {
      $config          = '/etc/ntp.conf'
      $config_template = 'ntp/ntp.conf.el.erb'
      $package_name    = [ 'ntp' ]
      $service_name    = 'ntpd'
      $servers         = [
        '0.centos.pool.ntp.org',
        '1.centos.pool.ntp.org',
        '2.centos.pool.ntp.org',
      ]
    }
    'SuSE': {
      $config          = '/etc/ntp.conf'
      $config_template = 'ntp/ntp.conf.suse.erb'
      $package_name    = [ 'ntp' ]
      $service_name    = 'ntp'
      $servers         = [
        '0.opensuse.pool.ntp.org',
        '1.opensuse.pool.ntp.org',
        '2.opensuse.pool.ntp.org',
        '3.opensuse.pool.ntp.org',
      ]
    }
    'FreeBSD': {
      $config          = '/etc/ntp.conf'
      $config_template = 'ntp/ntp.conf.freebsd.erb'
      $package_name    = ['net/ntp']
      $service_name    = 'ntpd'
      $servers         = [
        '0.freebsd.pool.ntp.org iburst maxpoll 9',
        '1.freebsd.pool.ntp.org iburst maxpoll 9',
        '2.freebsd.pool.ntp.org iburst maxpoll 9',
        '3.freebsd.pool.ntp.org iburst maxpoll 9',
      ]
    }
    'Archlinux': {
      $config          = '/etc/ntp.conf'
      $config_template = 'ntp/ntp.conf.archlinux.erb'
      $package_name    = ['ntp']
      $service_name    = 'ntpd'
      $servers         = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
      ]
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      case $::operatingsystem {
        'Gentoo': {
          $config          = '/etc/ntp.conf'
          $config_template = 'ntp/ntp.conf.gentoo.erb'
          $package_name    = ['net-misc/ntp']
          $service_name    = 'ntpd'
          $servers         = [
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
}
