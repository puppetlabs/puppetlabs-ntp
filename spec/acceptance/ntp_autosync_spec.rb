require 'spec_helper_acceptance'

case fact('osfamily')
when 'RedHat', 'FreeBSD', 'Linux', 'Gentoo'
  servicename = 'ntpd'
else
  servicename = 'ntp'
end

describe 'ntp::autosync parameter' do
  it 'sets up ntp' do
    apply_manifest("class { 'ntp': }", :catch_failures => true)
  end

  it 'sets the clock incorrectly and breaks ntp' do
    shell("puppet resource service #{servicename} ensure=stopped")
    shell('ntpdate time.nist.gov')
    #shell('time=`date --date="1 hour ago" +%T` ; date --set "${time}"')
    shell("date -s +'-1 hour'")
    shell('rm /etc/ntp.conf')
  end

  it 'runs with autosync => true' do
    pp = <<-EOS
      class { 'ntp':
        autosync => true,
      }
    EOS

    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stdout).to match(/Exec.*ntpdate/)
    end
  end

  it 'sets the clock incorrectly and breaks ntp' do
    shell("puppet resource service #{servicename} ensure=stopped")
    shell('ntpdate time.nist.gov')
    #shell('time=`date --date="1 hour ago" +%T` ; date --set "${time}"')
    shell("date -s +'-1 hour'")
    shell('rm /etc/ntp.conf')
  end

  it 'runs with autosync => false' do
    pp = <<-EOS
      class { 'ntp':
        autosync => false,
      }
    EOS

    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stdout).to_not match(/Exec.*ntpdate/)
    end
  end

end
