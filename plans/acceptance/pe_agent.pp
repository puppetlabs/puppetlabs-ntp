# @summary Install PE
#
# Install PE Agent
#
# @example
#   ntp::acceptance::pe_agent
plan ntp::acceptance::pe_agent() {
  #identify pe server and agent nodes
  $puppet_server =  get_targets('*').filter |$n| { $n.vars['role'] == 'ntpserver' }
  $puppet_agent =  get_targets('*').filter |$n| { $n.vars['role'] == 'ntpclient' }

  # install pe server
  run_plan(
    'deploy_pe::provision_agent',
    $puppet_agent,
    'master' => $puppet_server,
  )
}
