require 'spec_helper_acceptance'

case os[:family]
when 'freebsd'
  packagename = 'net/ntp'
when 'aix'
  packagename = 'bos.net.tcp.client'
when 'solaris'
  case linux_kernel_parameter('kernel.osrelease').value
  when %r{^5.10}
    packagename = ['SUNWntp4r', 'SUNWntp4u']
  when %r{^5.11}
    packagename = 'service/network/ntp'
  end
else
  if os[:family] == 'sles' && os[:release].start_with?('12', '15')
    'ntpd'
  else
    'ntp'
  end
end

config = if os[:family] == 'solaris'
           '/etc/inet/ntp.conf'
         else
           '/etc/ntp.conf'
         end

modulepath = run_shell('puppet config print modulepath').stdout.split(':')[0]
describe 'ntp class', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  it 'applies successfully' do
    pp = "class { 'ntp': }"

    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
  end

  describe 'config' do
    it 'sets the ntp.conf location' do
      pp = "class { 'ntp': config => '/etc/antp.conf' }"
      apply_manifest(pp, catch_failures: true)
      expect(file('/etc/antp.conf')).to be_file
    end
  end

  describe 'config_template' do
    before :all do
      run_shell("mkdir -p #{modulepath}/test/templates")
      # Add spurious template logic to verify the use of the correct template rendering engine
      run_shell("echo '<% [1].each do |i| %>erbserver<%= i %><%end %>' >> #{modulepath}/test/templates/ntp.conf.erb")
    end

    it 'sets the ntp.conf erb template location' do
      pp = "class { 'ntp': config_template => 'test/ntp.conf.erb' }"
      apply_manifest(pp, catch_failures: true)
      expect(file(config.to_s)).to be_file
      expect(file(config.to_s).content).to match 'erbserver1'
    end

    it 'sets the ntp.conf epp template location and the ntp.conf erb template location which should fail' do
      pp = "class { 'ntp': config_template => 'test/ntp.conf.erb', config_epp => 'test/ntp.conf.epp' }"
      expect(apply_manifest(pp, expect_failures: true).stderr).to match(%r{Cannot supply both config_epp and config_template}i)
    end
  end

  describe 'config_epp' do
    before :all do
      run_shell("mkdir -p #{modulepath}/test/templates")
      # Add spurious template logic to verify the use of the correct template rendering engine
      run_shell("echo '<% [1].each |$i| { -%>eppserver<%= $i %><% } -%>' >> #{modulepath}/test/templates/ntp.conf.epp")
    end

    it 'sets the ntp.conf epp template location' do
      pp = "class { 'ntp': config_epp => 'test/ntp.conf.epp' }"
      apply_manifest(pp, catch_failures: true)
      expect(file(config.to_s)).to be_file
      expect(file(config.to_s).content).to match 'eppserver1'
    end

    it 'sets the ntp.conf epp template location and the ntp.conf erb template location which should fail' do
      pp = "class { 'ntp': config_template => 'test/ntp.conf.erb', config_epp => 'test/ntp.conf.epp' }"
      expect(apply_manifest(pp, expect_failures: true).stderr).to match(%r{Cannot supply both config_epp and config_template}i)
    end
  end

  describe 'package' do
    pp = <<-MANIFEST
    class { 'ntp':
      package_ensure => present,
      package_name   => #{Array(packagename).inspect},
    }
    MANIFEST

    it 'installs the right package' do
      apply_manifest(pp, catch_failures: true)
      Array(packagename).each do |package|
        expect(package(package)).to be_installed
      end
    end
  end
end
