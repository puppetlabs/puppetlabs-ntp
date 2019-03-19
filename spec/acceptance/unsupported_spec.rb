require 'spec_helper_acceptance'

describe 'unsupported distributions and OSes', if: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  it 'fails' do
    pp = <<-MANIFEST
    class { 'ntp': }
    MANIFEST
    expect(apply_manifest(pp, expect_failures: true).stderr).to match(%r{is not supported on an}i)
  end
end
