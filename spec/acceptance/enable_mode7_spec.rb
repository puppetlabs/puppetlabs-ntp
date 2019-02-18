require 'spec_helper_acceptance'

config = if os[:family] == 'solaris'
           '/etc/inet/ntp.conf'
         else
           '/etc/ntp.conf'
         end

describe 'ntp class with enable_mode7:', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  context 'with enable' do
    let(:pp) { "class { 'ntp': enable_mode7 => true }" }

    it 'idempotent apply, file matches' do
      idempotent_apply(default, pp)
      expect(file(config.to_s).content).to match 'enable mode7'
    end
  end

  context 'with disable' do
    let(:pp) { "class { 'ntp': enable_mode7 => false }" }

    it 'idempotent apply, file matches' do
      idempotent_apply(default, pp)
      expect(file(config.to_s).content).not_to match 'enable mode7'
    end
  end
end
