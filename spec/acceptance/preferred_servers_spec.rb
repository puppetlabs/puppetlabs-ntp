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
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    expect(file(config.to_s)).to be_file
    expect(file(config.to_s).content).to match 'server a'
    expect(file(config.to_s).content).to match 'server b'
    expect(file(config.to_s).content).to match %r{server c (iburst\s|)prefer}
    expect(file(config.to_s).content).to match %r{server d (iburst\s|)prefer}
  end
end
