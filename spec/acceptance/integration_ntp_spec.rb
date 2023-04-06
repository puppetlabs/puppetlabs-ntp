# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'json'
require 'pry'

describe 'we are able to setup an ntp server, and connect a client to it', :integration do
  context 'when setting up the server' do
    before(:all) { change_target_host('ntpserver') }
    after(:all) { reset_target_host }

    describe 'set up ntpserver' do
      pp = <<-MANIFEST
      class { 'ntp': }
      MANIFEST

      it 'check the date is 2023 and set up the service' do
        idempotent_apply(pp)
        result = run_shell('date')
        expect(result.stdout).to match(%r{2023})
      end
    end
  end

  context 'when setting up the client' do
    before(:all) { change_target_host('ntpclient') }
    after(:all) { reset_target_host }

    describe 'go to the future' do
      it 'install ntpdate and check its 2023' do
        apply_manifest("package { 'ntpdate': ensure => present }")
        result = run_shell('date')
        expect(result.stdout).to match(%r{2023})
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
