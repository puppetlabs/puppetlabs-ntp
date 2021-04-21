# @summary Provisions machines
#
# Provisions machines for integration testing
#
# @example
#   ntp::provision_integration
plan ntp::provision_gcp(
  Optional[String] $image = 'centos-7',
  Optional[String] $provision_type = 'provision_service',
) {
  #provision server machine, set role
  run_task("provision::$provision_type", 'localhost',
    action => 'provision', platform => $image, vars => 'role: ntpserver')
  run_task("provision::$provision_type", 'localhost',
    action => 'provision', platform => $image, vars => 'role: ntpclient')
}
