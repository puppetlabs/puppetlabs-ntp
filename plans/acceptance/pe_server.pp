# @summary Install PE Server
#
# Install PE Server
#
# @example
#   ntp::acceptance::pe_server
plan ntp::acceptance::pe_server(
  Optional[String] $version = '2019.8.5',
  Optional[Hash] $pe_settings = { password => 'puppetlabs' }
) {
  #identify pe server node
  $puppet_server =  get_targets('*').filter |$n| { $n.vars['role'] == 'ntpserver' }

  # install pe server
  run_plan(
    'deploy_pe::provision_master',
    $puppet_server,
    'version' => $version,
    'pe_settings' => $pe_settings
  )
}
