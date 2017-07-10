require 'spec_helper_acceptance'

if (fact('osfamily') == 'Solaris')
  config = '/etc/inet/ntp.conf'
else
  config = '/etc/ntp.conf'
end

describe "ntp class with enable_mode7:", :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'should enable' do
    pp = "class { 'ntp': enable_mode7 => true }"

    it 'runs twice' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file("#{config}") do
      its(:content) { should match('enable mode7') }
    end
  end

  context 'should not enable' do
    pp = "class { 'ntp': enable_mode7 => false }"

    it 'runs twice' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file("#{config}") do
      its(:content) { should_not match('enable mode7') }
    end
  end

end
