# @summary Provisions machines
#
# Provisions machines for integration testing
#
# @example
#   ntp::provision_integration
plan ntp::provision_gcp(
  Optional[String] $gcp_image = 'centos-7',
) {
  #provision server machine, set role
  run_task('provision::provision_service', 'localhost',
    action => 'provision', platform => $gcp_image, vars => 'role: ntpserver')
  run_task('provision::provision_service', 'localhost',
    action => 'provision', platform => $gcp_image, vars => 'role: ntpclient')
}
