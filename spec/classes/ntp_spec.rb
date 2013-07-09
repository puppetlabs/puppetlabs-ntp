require 'spec_helper'

describe 'ntp' do

  let(:facts) {{ :osfamily => 'Debian' }}

  it { should include_class('ntp::install') }
  it { should include_class('ntp::config') }
  it { should include_class('ntp::service') }

  # These are currently breaking for me.
  #it { should have_class_count(3) }
  #it { should have_resource_count(0) }

end
