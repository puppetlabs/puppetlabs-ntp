# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'json'
require 'pry'

describe 'we are able to setup an ntp server, and connect a client to it', :integration do
  context 'set up the server' do
    before(:all) { change_target_host('ntpserver') }
    after(:all) { reset_target_host }
    servicename = if os[:family] == 'sles' && os[:release].start_with?('12', '15')
                    'ntpd'
                  else
                    'ntp'
                  end
    describe 'set up ntpserver' do
      it 'check the date is 2021' do
        result = run_shell('date')
        expect(result.stdout).to match(%r{2021})
      end
      pp = <<-MANIFEST
      class { 'ntp': }
      MANIFEST
      it 'sets up the service' do
        idempotent_apply(pp)
        expect(service(servicename)).to be_running
        expect(service(servicename)).to be_enabled
      end
    end
  end
  context 'set up the client' do
    before(:all) { change_target_host('ntpclient') }
    after(:all) { reset_target_host }
    describe 'go to the future' do
      it 'its 2021' do
        result = run_shell('date')
        expect(result.stdout).to match(%r{2021})
      end
      it 'install ntpdate' do
        apply_manifest("package { 'ntpdate': ensure => present }")
      end
      it 'disable ntp auto-sync' do
        result = run_shell('timedatectl set-ntp false')
        expect(result.exit_code).to eq(0)
      end
      it 'go forward to 2022' do
        result = run_shell('date --set="$(date --date="next year")"')
        expect(result.stdout).to match(%r{2022})
        expect(result.exit_code).to eq(0)
      end
      it 'changed 2022' do
        result = run_shell('date')
        expect(result.stdout).to match(%r{2022})
      end
    end
  end
end
