# frozen_string_literal: true

require 'spec_helper_acceptance'

config = if os[:family] == 'solaris'
           '/etc/inet/ntp.conf'
         else
           '/etc/ntp.conf'
         end

describe 'preferred servers', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  pp = <<-MANIFEST
    class { '::ntp':
      servers           => ['a', 'b', 'c', 'd'],
      preferred_servers => ['c', 'd'],
    }
  MANIFEST

  it 'applies cleanly' do
    idempotent_apply(pp)
    expect(file(config.to_s)).to be_file
    ['server a', 'server b', %r{server c (iburst\s|)prefer}, %r{server d (iburst\s|)prefer}].each do |check|
      expect(file(config.to_s).content).to match(check)
    end
  end
end
