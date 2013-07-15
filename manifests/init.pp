class ntp (
  $autoupdate      = $ntp::params::autoupdate,
  $config          = $ntp::params::config,
  $config_template = $ntp::params::config_template,
  $package_ensure  = $ntp::params::package_ensure,
  $package_name    = $ntp::params::package_name,
  $panic           = $ntp::params::panic,
  $restrict        = $ntp::params::restrict,
  $servers         = $ntp::params::servers,
  $service_enable  = $ntp::params::service_enable,
  $service_ensure  = $ntp::params::service_ensure,
  $service_manage  = $ntp::params::service_manage,
  $service_name    = $ntp::params::service_name,
) inherits ntp::params {

  if $autoupdate {
    notice('autoupdate parameter has been deprecated and replaced with package_ensure.  Set this to latest for the same behavior as autoupdate => true.')
  }

  include '::ntp::install'
  include '::ntp::config'
  include '::ntp::service'

  # Anchor this as per #8140 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': }
  anchor { 'ntp::end': }

  Anchor['ntp::begin'] -> Class['::ntp::install'] -> Class['::ntp::config']
    ~> Class['::ntp::service'] -> Anchor['ntp::end']

}
