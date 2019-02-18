require 'spec_helper_acceptance'

config = if os[:family] == 'solaris'
           '/etc/inet/ntp.conf'
         else
           '/etc/ntp.conf'
         end

describe 'ntp class with restrict:', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  context 'when running' do
    let(:pp) { "class { 'ntp': restrict => ['test restrict']}" }

    it 'runs twice' do
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
      apply_manifest(pp, catch_changes: true)
      expect(file(config.to_s)).to be_file
      expect(file(config.to_s).content).to match 'test restrict'
    end
  end
end
