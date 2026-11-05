# frozen_string_literal: true

include PuppetLitmus

UNSUPPORTED_PLATFORMS = ['windows', 'darwin'].freeze

RSpec.configure do |c|
  c.before :suite do
    # SUSE's ntpd.service has ConditionVirtualization=!container, so systemd silently skips
    # starting ntpd in the docker-provisioned SLES 15 target. Reset the unit's conditions there
    # so the service tests exercise ntpd as they would on a real host.
    if os[:family] == 'sles'
      run_shell(<<~SHELL)
        if systemd-detect-virt --quiet --container; then
          mkdir -p /etc/systemd/system/ntpd.service.d
          printf '[Unit]\\nConditionVirtualization=\\n' > /etc/systemd/system/ntpd.service.d/container.conf
          systemctl daemon-reload
        fi
      SHELL
    end

    # litmusimage's ubuntu:26.04 docker image disables systemd-tmpfiles-setup, so /run/lock
    # never gets created. ntpsec's startup wrapper assumes it exists and fails trying to create
    # its lock file there. Pre-create it so the service tests exercise ntpsec as they would on
    # a real host.
    if os[:family] == 'ubuntu' && os[:release] == '26.04'
      run_shell('mkdir -p /run/lock')
    end
  end
end
