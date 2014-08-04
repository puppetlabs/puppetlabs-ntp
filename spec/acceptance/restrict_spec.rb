require 'spec_helper_acceptance'

describe "ntp class with restrict:", :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'should run successfully' do
    it 'runs twice' do
      pp = "class { 'ntp': restrict => ['test restrict']}"
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end
  end

  describe file('/etc/ntp.conf') do
    it { should contain('test restrict') }
  end

end
