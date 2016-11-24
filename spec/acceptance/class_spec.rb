require 'spec_helper_acceptance'

describe 'ntp class:', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should run successfully', :tier_high => true do
    pp = "class { 'ntp': }"

    # Apply twice to ensure no errors the second time.
    execute_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to match(/error/i)
    end
    execute_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to eq(/error/i)

      expect(r.exit_code).to be_zero
    end
  end

  context 'service_ensure => stopped:', :tier_medium => true do
    it 'runs successfully' do
      pp = "class { 'ntp': service_ensure => stopped }"

      execute_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end

  context 'service_ensure => running:', :tier_low => true do
    it 'runs successfully' do
      pp = "class { 'ntp': service_ensure => running }"

      execute_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
    end
  end
end
