require 'spec_helper_acceptance'

config = if os[:family] == 'solaris'
           '/etc/inet/ntp.conf'
         else
           '/etc/ntp.conf'
         end

describe 'ntp class with disable_monitor:', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  context 'with should disable' do
    let(:pp) { "class { 'ntp': disable_monitor => true }" }

    it 'idempotent apply, file matches' do
      idempotent_apply(default, pp)
      expect(file(config.to_s).content).to match 'disable monitor'
    end
  end

  context 'when enabled' do
    let(:pp) { "class { 'ntp': disable_monitor => false }" }

    it 'idempotent apply, file matches' do
      idempotent_apply(default, pp)
      expect(file(config.to_s).content).not_to match 'disable monitor'
    end
  end
end
