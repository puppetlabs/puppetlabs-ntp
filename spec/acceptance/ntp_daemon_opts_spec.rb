require 'spec_helper_acceptance'

config = if fact('osfamily') == 'redhat'
           '/etc/sysconfig/ntp'
         else
           '/etc/default/ntp'
         end

describe 'ntp class with daemon options:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'when successful' do
    let(:pp) { "class { 'ntp': user => 'ntp', options => '-g' }" }

    it 'runs twice' do
      2.times do
        apply_manifest(pp, catch_failures: true) do |r|
          expect(r.stderr).not_to match(%r{error}i)
        end
      end
    end
  end

  describe file(config.to_s) do
    its(:content) { is_expected.to match(/(OPTIONS|NTPD_OPTS)='-u ntp:ntp -g'/) }
  end

end
