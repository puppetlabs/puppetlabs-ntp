class ntp::params {

  case $::osfamily {
    'debian': {
      $package = 'ntp'
      $service = 'ntp'
      $config_file = '/etc/ntp.conf'
      $config_template = 'ntpd.conf.debian.erb'
      $servers = [ '0.debian.pool.ntp.org iburst',
                   '1.debian.pool.ntp.org iburst',
                   '2.debian.pool.ntp.org iburst'
      ]
    } 

    'redhat': {
      $package = 'ntp'
      $service = 'ntpd'
      $config_file = '/etc/ntp.conf'
      $config_template = 'ntp.conf.el.erb'
      $servers = [ '0.centos.pool.ntp.org',
                   '1.centos.pool.ntp.org',
                   '2.centos.pool.ntp.org'
      ]
    }

    'suse': {
      $package = 'ntp'
      $service = 'ntpd'
      $config_file = '/etc/ntp.conf'
      $config_template = 'ntp.conf.suse.erb'
      $servers = [ '0.opensuse.pool.ntp.org',
                   '1.opensuss.pool.ntp.org',
                   '2.opensuss.pool.ntp.org',
                   '3.opensuss.pool.ntp.org'
      ] 
    }

    'freebsd': {
      $package = 'net/ntp'
      $service = 'ntpd'
      $config_file = '/etc/ntp.conf'
      $config_template = 'ntp.conf.freebsd.erb'
      $servers = [ '0.freebsd.pool.ntp.org iburst maxpool 9',
                   '1.freebsd.pool.ntp.org iburst maxpool 9',
                   '2.freebsd.pool.ntp.org iburst maxpool 9',
                   '3.freebsd.pool.ntp.org iburst maxpool 9'
      ]
    }

    'archlinux': {
      $package = 'ntp'
      $service = 'ntpd'
      $config_file = '/etc/ntp.conf'
      $config_template = 'ntp.conf.archlinux.erb'
      $servers = [ '0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org' ]
    }

    default: {fail("OS family ${::osfamily} not supported by this module!")} 
  }
}
