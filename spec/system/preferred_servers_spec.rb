require 'spec_helper_system'

describe 'preferred servers' do
  it 'applies cleanly' do
    puppet_apply(%{
      class { '::ntp':
        servers           => ['a', 'b', 'c', 'd'],
        preferred_servers => ['c', 'd'],
      }
    })
  end

  describe file('/etc/ntp.conf') do
    it { should be_file }
    it { should contain 'server a' }
    it { should contain 'server b' }
    it { should contain 'server c prefer' }
    it { should contain 'server d prefer' }
  end
end
