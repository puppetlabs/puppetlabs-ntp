class ntp::params {
  case $operatingsystem {
    debian, ubuntu: {
      $supported       = true
      $pkg_name        = [ "ntp" ]
      $svc_name        = "ntp"
      $config          = "/etc/ntp.conf"
      $config_tpl      = "ntp.conf.debian.erb"
      $servers_default = [ "0.debian.pool.ntp.org iburst",
                           "1.debian.pool.ntp.org iburst",
                           "2.debian.pool.ntp.org iburst",
                           "3.debian.pool.ntp.org iburst", ]
    }
    centos, redhat, oel, linux: {
      $supported       = true
      $pkg_name        = [ "ntp" ]
      $svc_name        = "ntpd"
      $config          = "/etc/ntp.conf"
      $config_tpl      = "ntp.conf.el.erb"
      $servers_default = [ "0.centos.pool.ntp.org",
                          "1.centos.pool.ntp.org",
                          "2.centos.pool.ntp.org", ]
    }
    default: {
      $supported = false
      notify { "${module_name}_unsupported":
        message => "The ${module_name} module is not supported on ${operatingsystem}",
      }
    }
  }
}
