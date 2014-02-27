require 'spec_helper_acceptance'

describe "ntp class with disable_monitor:", :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'should run successfully' do
    pp = "class { 'ntp': disable_monitor => true }"

    it 'runs twice' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/ntp.conf') do
      it { should contain('disable monitor') }
    end
  end

  context 'should run successfully' do
    pp = "class { 'ntp': disable_monitor => false }"

    it 'runs twice' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/ntp.conf') do
      it { should_not contain('disable monitor') }
    end
  end

end
