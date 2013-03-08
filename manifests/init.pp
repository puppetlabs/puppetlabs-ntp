# Class: ntp
#
#   This module manages the ntp service.
#
#   Jeff McCune <jeff@puppetlabs.com>
#   2011-02-23
#
#   Tested platforms:
#    - Debian 6.0 Squeeze
#    - CentOS 5.4
#    - Amazon Linux 2011.09
#    - FreeBSD 9.0
#    - Archlinux
#
# Parameters:
#
#   $servers = [ '0.debian.pool.ntp.org iburst',
#                '1.debian.pool.ntp.org iburst',
#                '2.debian.pool.ntp.org iburst',
#                '3.debian.pool.ntp.org iburst', ]
#
#   $restrict = true
#     Whether to restrict ntp daemons from allowing others to use as a server.
#
#   $autoupdate = false
#     Whether to update the ntp package automatically or not.
#
#   $enable = true
#     Automatically start ntp deamon on boot.
#
#   $template = '${module_name}/${config_tpl}'
#     Override with your own explicit template.
#
# Actions:
#
#  Installs, configures, and manages the ntp service.
#
# Requires:
#
# Sample Usage:
#
#   class { "ntp":
#     servers    => [ 'time.apple.com' ],
#     autoupdate => false,
#   }
#
# [Remember: No empty lines between comments and class definition]
class ntp($servers='UNSET',
          $ensure='running',
          $enable=true,
          $restrict=true,
          $config_template=undef,
          $autoupdate=false
) {

  if ! ($ensure in [ 'running', 'stopped' ]) {
    fail('ensure parameter must be running or stopped')
  }

  if $autoupdate == true {
    $package_ensure = latest
  } elsif $autoupdate == false {
    $package_ensure = present
  } else {
    fail('autoupdate parameter must be true or false')
  }

  case $::osfamily {
    Debian: {
      $supported  = true
      $pkg_name   = [ 'ntp' ]
      $svc_name   = 'ntp'
      $config     = '/etc/ntp.conf'
      $config_tpl = 'ntp.conf.debian.erb'
      if ($servers == 'UNSET') {
        $servers_real = [ '0.debian.pool.ntp.org iburst',
                          '1.debian.pool.ntp.org iburst',
                          '2.debian.pool.ntp.org iburst',
                          '3.debian.pool.ntp.org iburst', ]
      } else {
        $servers_real = $servers
      }
    }
    RedHat: {
      $supported  = true
      $pkg_name   = [ 'ntp' ]
      $svc_name   = 'ntpd'
      $config     = '/etc/ntp.conf'
      $config_tpl = 'ntp.conf.el.erb'
      if ($servers == 'UNSET') {
        $servers_real = [ '0.centos.pool.ntp.org',
                          '1.centos.pool.ntp.org',
                          '2.centos.pool.ntp.org', ]
      } else {
        $servers_real = $servers
      }
    }
    SuSE: {
      $supported  = true
      $pkg_name   = [ 'ntp' ]
      $svc_name   = 'ntp'
      $config     = '/etc/ntp.conf'
      $config_tpl = 'ntp.conf.suse.erb'
      if ($servers == 'UNSET') {
        $servers_real = [ '0.opensuse.pool.ntp.org',
                          '1.opensuse.pool.ntp.org',
                          '2.opensuse.pool.ntp.org',
                          '3.opensuse.pool.ntp.org', ]
      } else {
        $servers_real = $servers
      }
    }
    FreeBSD: {
      $supported  = true
      $pkg_name   = ['net/ntp']
      $svc_name   = 'ntpd'
      $config     = '/etc/ntp.conf'
      $config_tpl = 'ntp.conf.freebsd.erb'
      if ($servers == 'UNSET') {
        $servers_real = [ '0.freebsd.pool.ntp.org iburst maxpoll 9',
                          '1.freebsd.pool.ntp.org iburst maxpoll 9',
                          '2.freebsd.pool.ntp.org iburst maxpoll 9',
                          '3.freebsd.pool.ntp.org iburst maxpoll 9', ]
      } else {
        $servers_real = $servers
      }
    }

    Linux: {
      if ($::operatingsystem == 'Archlinux') {
        $supported = true
        $pkg_name = ['ntp']
        $svc_name = 'ntpd'
        $config = '/etc/ntp.conf'
        $config_tpl = 'ntp.conf.archlinux.erb'

        if ($servers == 'UNSET') {
          $servers_real = [ '0.pool.ntp.org',
                            '1.pool.ntp.org',
                            '2.pool.ntp.org' ]
        } else {
          $servers_real = $servers
        }
      } else {
        fail("The ${module_name} module is not supported on an ${::operatingsystem} system")
      }
    }

    default: {
      fail("The ${module_name} module is not supported on ${::osfamily} based systems")
    }
  }

  if ($config_template == undef) {
    $template_real = "${module_name}/${config_tpl}"
  } else {
    $template_real = $config_template
  }

  package { 'ntp':
    ensure => $package_ensure,
    name   => $pkg_name,
  }

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template($template_real),
    require => Package[$pkg_name],
  }

  service { 'ntp':
    ensure     => $ensure,
    enable     => $enable,
    name       => $svc_name,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => [ Package[$pkg_name], File[$config] ],
  }
}
