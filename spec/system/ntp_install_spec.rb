require 'spec_helper_system'

describe 'ntp::install class' do
  let(:os) {
    node.facts['osfamily']
  }

  describe package('ntp') do
    it { should be_installed }
  end
end
