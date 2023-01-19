# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'json'
require 'pry'

describe 'we are able to setup an ntp server, and connect a client to it', :integration do
  context 'set up the server' do
    before(:all) { change_target_host('ntpserver') }
    after(:all) { reset_target_host }
    describe 'set up ntpserver' do
      it 'check the date is 2023' do
        result = run_shell('date')
        expect(result.stdout).to match(%r{2023})
      end
      pp = <<-MANIFEST
      class { 'ntp': }
      MANIFEST
      it 'sets up the service' do
        idempotent_apply(pp)
      end
    end
  end
  context 'set up the client' do
    before(:all) { change_target_host('ntpclient') }
    after(:all) { reset_target_host }
    describe 'go to the future' do
      it 'its 2023' do
        result = run_shell('date')
        expect(result.stdout).to match(%r{2023})
      end
      it 'install ntpdate' do
        apply_manifest("package { 'ntpdate': ensure => present }")
      end
      it 'disable ntp auto-sync' do
        result = run_shell('timedatectl set-ntp false')
        expect(result.exit_code).to eq(0)
      end
      it 'go forward to 2024' do
        result = run_shell('date --set="$(date --date="next year")"')
        expect(result.stdout).to match(%r{2024})
        expect(result.exit_code).to eq(0)
      end
      it 'changed 2024' do
        result = run_shell('date')
        expect(result.stdout).to match(%r{2024})
      end
    end
  end
end
