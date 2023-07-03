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

      it 'check the date is current and set up the service' do
        idempotent_apply(pp)
        result = run_shell('date')
        expect(result.stdout).to match(%r{#{Time.now.year}})
      end
    end
  end

  context 'when setting up the client' do
    before(:all) { change_target_host('ntpclient') }
    after(:all) { reset_target_host }

    describe 'go to the future' do
      it 'install ntpdate and check the year is current' do
        apply_manifest("package { 'ntpdate': ensure => present }")
        result = run_shell('date')
        expect(result.stdout).to match(%r{#{Time.now.year}})
      end

      it 'disable ntp auto-sync' do
        result = run_shell('timedatectl set-ntp false')
        expect(result.exit_code).to eq(0)
      end

      it 'go forward to to next year' do
        result = run_shell('date --set="$(date --date="next year")"')
        expect(result.stdout).to match(%r{#{Time.now.year + 1}})
        expect(result.exit_code).to eq(0)
      end

      it 'changed to next year' do
        result = run_shell('date')
        expect(result.stdout).to match(%r{#{Time.now.year + 1}})
      end
    end
  end
end
