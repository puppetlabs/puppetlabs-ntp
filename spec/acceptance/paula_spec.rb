require 'spec_helper_acceptance'
require 'specinfra'

a1 = find_host_with_role('a1')
a2 = find_host_with_role('a2')

  pp1 = <<-EOS
      class { '::ntp': servers => ['a', 'b', 'c', 'd'],preferred_servers => ['c', 'd'],}
  EOS

  pp2 = <<-EOS
      class { '::ntp':servers => ['1', '2', '3', '4'], preferred_servers => ['2', '4'],}
  EOS

  pp = <<-EOS
      class { '::ntp':}
  EOS

  describe "Multinode tests", :multinode => true do
    it 'System test - apply 2 different manifests, confirm same config' do
      # Putting the servers into a known state
      # execute_manifest_on(hosts, pp4, :catch_failures => true, :acceptable_exit_codes => [0, 2])
      execute_manifest_on(a1, pp, :catch_failures => true, :acceptable_exit_codes => [0, 2])
      execute_manifest_on(a2, pp, :catch_failures => true, :acceptable_exit_codes => [0, 2])

      # Doing an agent run to configure preferred servers on specific server
      execute_manifest_on(a1, pp1, :catch_failures => true, :acceptable_exit_codes => [0, 2])

      # Doing an agent run to configure preferred servers on specific server
      execute_manifest_on(a2, pp2, :catch_failures => true, :acceptable_exit_codes => [0, 2])

      # Doing a final run to ensure the first server configures to the same as the second
      on a1, 'puppet agent --test --environment production', :catch_failures => true, :acceptable_exit_codes => [0, 2]
    end

    # Checking file content is as expected on one server
    it 'Checks file content is correct on a1' do
      result1 = on(a1, 'cat /etc/ntp.conf' )
      expect( result1.stdout ).to match 'server 1'
      expect( result1.stdout ).to match 'server 3'
      expect( result1.stdout ).to match /server 2 (iburst\s|)prefer/
      expect( result1.stdout ).to match /server 4 (iburst\s|)prefer/
    end

    # Checking file content is as expected on one server
    it 'Checks file content is correct on a2' do
      result2 = on(a2, 'cat /etc/ntp.conf' )
      expect( result2.stdout ).to match 'server 1'
      expect( result2.stdout ).to match 'server 3'
      expect( result2.stdout ).to match /server 2 (iburst\s|)prefer/
      expect( result2.stdout ).to match /server 4 (iburst\s|)prefer/
    end
  end

describe 'service parameters', :singlenode => true do
  it 'starts the service' do
    pp = <<-EOS
      class { 'ntp': service_enable => true, service_ensure => running, service_manage => true,}
    EOS
    execute_manifest(pp, :catch_failures => true)
  end
  it_should_behave_like 'running'
end
