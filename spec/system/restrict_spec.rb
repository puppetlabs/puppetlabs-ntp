require 'spec_helper_system'

describe "ntp class with restrict:" do
  context 'should run successfully' do
    pp = "class { 'ntp': restrict => ['test restrict']}"

    context puppet_apply(pp) do
      its(:stderr) { should be_empty }
      its(:exit_code) { should_not == 1 }
      its(:refresh) { should be_nil }
      its(:stderr) { should be_empty }
      its(:exit_code) { should be_zero }
    end
  end

  describe file('/etc/ntp.conf') do
    it { should contain('test restrict') }
  end

end
