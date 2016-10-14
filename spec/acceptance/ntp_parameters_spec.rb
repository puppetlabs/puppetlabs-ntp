require 'spec_helper_acceptance'

case fact('osfamily')
when 'FreeBSD'
  packagename = 'net/ntp'
when 'Gentoo'
  packagename = 'net-misc/ntp'
when 'Linux'
  case fact('operatingsystem')
  when 'ArchLinux'
    packagename = 'ntp'
  when 'Gentoo'
    packagename = 'net-misc/ntp'
  end
when 'AIX'
  packagename = 'bos.net.tcp.client'
when 'Solaris'
  case fact('kernelrelease')
  when '5.10'
    packagename = ['SUNWntpr','SUNWntpu']
  when '5.11'
    packagename = 'service/network/ntp'
  end
else
  if fact('operatingsystem') == 'SLES' and fact('operatingsystemmajrelease') == '12'
    servicename = 'ntpd'
  else
    servicename = 'ntp'
  end
end

if (fact('osfamily') == 'RedHat')
  keysfile = '/etc/ntp/keys'
elsif (fact('osfamily') == 'Solaris')
  keysfile = '/etc/inet/ntp.keys'
else
  keysfile = '/etc/ntp.keys'
end

if (fact('osfamily') == 'Solaris')
  config = '/etc/inet/ntp.conf'
else
  config = '/etc/ntp.conf'
end

describe "ntp class:", :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  # FM-5470, this was added to reset failed count and work around puppet 3.x
  if ( (fact('operatingsystem') == 'SLES' and fact('operatingsystemmajrelease') == '12') or (fact('operatingsystem') == 'Scientific' and fact('operatingsystemmajrelease') == '7') )
    after :each do
      shell('systemctl reset-failed ntpd.service')
    end
  end

  it 'applies successfully' do
    pp = "class { 'ntp': }"

    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to match(/error/i)
    end
  end

  describe 'config' do
    it 'sets the ntp.conf location' do
      pp = "class { 'ntp': config => '/etc/antp.conf' }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/antp.conf') do
      it { should be_file }
    end
  end

  describe 'config_template' do
    before :all do
      modulepath = default['distmoduledir']
      shell("mkdir -p #{modulepath}/test/templates")
      # Add spurious template logic to verify the use of the correct template rendering engine
      shell("echo '<% [1].each do |i| %>erbserver<%= i %><%end %>' >> #{modulepath}/test/templates/ntp.conf.erb")
    end

    it 'sets the ntp.conf erb template location' do
      pp = "class { 'ntp': config_template => 'test/ntp.conf.erb' }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      it { should be_file }
      its(:content) { should match 'erbserver1' }
    end

    it 'sets the ntp.conf epp template location and the ntp.conf erb template location which should fail' do
      pp = "class { 'ntp': config_template => 'test/ntp.conf.erb', config_epp => 'test/ntp.conf.epp' }"
      expect(apply_manifest(pp, :expect_failures => true).stderr).to match(/Cannot supply both config_epp and config_template/i)
    end
  end

  describe 'config_epp' do
    before :all do
      modulepath = default['distmoduledir']
      shell("mkdir -p #{modulepath}/test/templates")
      # Add spurious template logic to verify the use of the correct template rendering engine
      shell("echo '<% [1].each |$i| { -%>eppserver<%= $i %><% } -%>' >> #{modulepath}/test/templates/ntp.conf.epp")
    end

    it 'sets the ntp.conf epp template location' do
      pp = "class { 'ntp': config_epp => 'test/ntp.conf.epp' }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      it { should be_file }
      its(:content) { should match 'eppserver1' }
    end

    it 'sets the ntp.conf epp template location and the ntp.conf erb template location which should fail' do
      pp = "class { 'ntp': config_template => 'test/ntp.conf.erb', config_epp => 'test/ntp.conf.epp' }"
      expect(apply_manifest(pp, :expect_failures => true).stderr).to match(/Cannot supply both config_epp and config_template/i)
    end
  end

  describe 'driftfile' do
    it 'sets the driftfile location' do
      pp = "class { 'ntp': driftfile => '/tmp/driftfile' }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      it { should be_file }
      its(:content) { should match 'driftfile /tmp/driftfile' }
    end
  end

  describe 'keys' do
    it 'enables the key parameters' do
      pp = <<-EOS
      class { 'ntp':
        keys_enable     => true,
        keys_controlkey => 15,
        keys_requestkey => 1,
        keys_trusted    => [ 1, 2 ],
        keys            => [ '1 M AAAABBBB' ],
      }
      EOS
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      it { should be_file }
      its(:content) { should match "keys #{keysfile}" }
      its(:content) { should match 'controlkey 15' }
      its(:content) { should match 'requestkey 1' }
      its(:content) { should match 'trustedkey 1 2' }
    end

    describe file(keysfile) do
      it { should be_file }
      its(:content) { should match '1 M AAAABBBB' }
    end
  end

  describe 'package' do
    it 'installs the right package' do
      pp = <<-EOS
      class { 'ntp':
        package_ensure => present,
        package_name   => #{Array(packagename).inspect},
      }
      EOS
      apply_manifest(pp, :catch_failures => true)
    end

    Array(packagename).each do |package|
      describe package(package) do
        it { should be_installed }
      end
    end
  end

  describe 'panic => 0' do
    it 'disables the tinker panic setting' do
      pp = <<-EOS
      class { 'ntp':
        panic => 0,
      }
      EOS
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      its(:content) { should match 'tinker panic 0' }
    end
  end

  describe 'panic => 1' do
    it 'enables the tinker panic setting' do
      pp = <<-EOS
      class { 'ntp':
        panic => 1,
      }
      EOS
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      its(:content) { should match 'tinker panic 1' }
    end
  end

  describe 'udlc' do
    it 'adds a udlc' do
      pp = "class { 'ntp': udlc => true }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      it { should be_file }
      its(:content) { should match '127.127.1.0' }
    end
  end

  describe 'udlc_stratum' do
    it 'sets the stratum value when using udlc' do
      pp = "class { 'ntp': udlc => true, udlc_stratum => 10 }"
      apply_manifest(pp, :catch_failures => true)
    end

    describe file("#{config}") do
      it { should be_file }
      its(:content) { should match 'stratum 10' }
    end
  end

end
