require 'spec_helper_acceptance'

if (fact('osfamily') == 'Solaris')
  config = '/etc/inet/ntp.conf'
else
  config = '/etc/ntp.conf'
end

describe "ntp class with statistics:", :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'should run successfully' do
    it 'runs twice' do
      pp = "class { 'ntp': statistics => ['loopstats'], disable_monitor => false}"
      2.times do
        apply_manifest(pp, :catch_failures => true) do |r|
          expect(r.stderr).not_to match(/error/i)
        end
      end
    end
  end

  describe file("#{config}") do
    its(:content) { should match('filegen loopstats file loopstats type day enable') }
  end

  describe file("#{config}") do
    its(:content) { should match('statsdir /var/log/ntpstats') }
  end

end
