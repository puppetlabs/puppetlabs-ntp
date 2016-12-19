# ntp

#### Table of Contents


1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with ntp](#setup)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)


## Module description

The ntp module installs, configures, and manages the NTP service across a range of operating systems and distributions.

## Setup

### Beginning with ntp

`include '::ntp'` is enough to get you up and running. To pass in parameters specifying which servers to use:

```puppet
class { '::ntp':
  servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
}
```

## Usage

All parameters for the ntp module are contained within the main `::ntp` class, so for any function of the module, set the options you want. See the common usages below for examples

### Install and enable NTP

```puppet
include '::ntp'
```

### Change NTP servers

```puppet
class { '::ntp':
  servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
}
```

### Restrict who can connect

```puppet
class { '::ntp':
  servers  => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  restrict => ['127.0.0.1'],
}
```

### Install a client that can't be queried

```puppet
class { '::ntp':
  servers   => ['ntp1.corp.com', 'ntp2.corp.com'],
  restrict  => [
    'default ignore',
    '-6 default ignore',
    '127.0.0.1',
    '-6 ::1',
    'ntp1.corp.com nomodify notrap nopeer noquery',
    'ntp2.corp.com nomodify notrap nopeer noquery'
  ],
}
```

### Listen on specific interfaces

Restricting NTP to a specific interface is especially useful on Openstack node, which may have numerous virtual interfaces.

```puppet
class { '::ntp':
  servers  => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  interfaces => ['127.0.0.1', '1.2.3.4']
}
```

### Opt out of Puppet controlling the service

```puppet
class { '::ntp':
  servers        => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  restrict       => ['127.0.0.1'],
  service_manage => false,
}
```

### Configure and run ntp without installing

```puppet
class { '::ntp':
  package_manage => false,
}
```

### Pass in a custom template

```puppet
class { '::ntp':
  servers         => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  restrict        => ['127.0.0.1'],
  service_manage  => false,
  config_epp      => 'different/module/custom.template.epp',
}
```

## Reference

### Classes

#### Public classes

* ntp: Main class, includes all other classes.

#### Private classes

* ntp::install: Handles the packages.
* ntp::config: Handles the configuration file.
* ntp::service: Handles the service.

### Parameters

The following parameters are available in the `::ntp` class:

#### `broadcastclient`

Boolean. Enables reception of broadcast server messages to any local interface.

#### `config`

Stdlib::Absolutepath. Specifies a file for NTP's configuration info. Default value: '/etc/ntp.conf' (or '/etc/inet/ntp.conf' on Solaris)

#### `config_dir`

Optional. Stdlib::Absolutepath. Specifies a directory for the NTP configuration files. Default value: undef

####`config_file_mode`

String. Specifies a file mode for the ntp configuration file. Default value: '0664'.

#### `config_template`

Optional. String. Specifies an absolute or relative file path to an ERB template for the config file. Example value: 'ntp/ntp.conf.erb'. A validation error is thrown if both this **and** the `config_epp` parameter are specified.

#### `config_epp`

Optional. String. Specifies an absolute or relative file path to an EPP template for the config file. Example value: 'ntp/ntp.conf.epp'. A validation error is thrown if both this **and** the `config_template` parameter are specified.

#### `disable_auth`

Boolean. Disables cryptographic authentication for broadcast client, multicast
client, and symmetric passive associations.

#### `disable_dhclient`

Boolean. Disables `ntp-servers` in `dhclient.conf` to prevent Dhclient from managing the NTP configuration.

#### `disable_kernel`

Boolean. Disables kernel time discipline.

#### `disable_monitor`

Boolean. Disables the monitoring facility in NTP. Default value: true.

#### `driftfile`

Stdlib::Absolutepath. Specifies an NTP driftfile. Default value: '/var/lib/ntp/drift' (except on AIX and Solaris).

#### `fudge`

Optional. Array[String]. Provides additional information for individual clock drivers. Default value: [ ]

#### `iburst_enable`

Boolean. Specifies whether to enable the iburst option for every NTP peer. Default value: false (true on AIX and Debian).

#### `interfaces`

Array[String]. Specifies one or more network interfaces for NTP to listen on. Default value: [ ]

#### `interfaces_ignore`

Array[String]. Specifies one or more ignore pattern for the NTP listener configuration (for example: all, wildcard, ipv6). Default value: [ ].

#### `keys`

Array[String]. Distributes keys to keys file. Default value: [ ]

#### `keys_controlkey`

Optional. Ntp::Key_id. Specifies the key identifier to use with the ntpq utility. Value in the range of 1 to 65,534 inclusive. Default value: ' '

#### `keys_enable`

Boolean. Whether to enable key-based authentication. Default value: false.

#### `keys_file`

Stdlib::Absolutepath. Specifies the complete path and location of the MD5 key file containing the keys and key identifiers used by ntpd, ntpq and ntpdc when operating with symmetric key cryptography. Default value: `/etc/ntp.keys` (on RedHat and Amazon, `/etc/ntp/keys`).

#### `keys_requestkey`

Optional. Ntp::Key_id. Specifies the key identifier to use with the ntpdc utility program. Value in the range of 1 to 65,534 inclusive. Default value: ' '

#### `keys_trusted`:
Optional. Array[Ntp::Key_id]. Provides one or more keys to be trusted by NTP. Default value: [ ].

#### `leapfile`

Optional. Stdlib::Absolutepath. Specifies a leap second file for NTP to use. Default value: ' '.

#### `logfile`

Optional. Stdlib::Absolutepath. Specifies a log file for NTP to use instead of syslog. Default value: ' '.

#### `minpoll`

Optional. Ntp::Poll_interval. Sets Puppet to non-standard minimal poll interval of upstream servers. Values: 3 to 16. Default: undef.

#### `maxpoll`

Optional. Ntp::Poll_interval. Sets use non-standard maximal poll interval of upstream servers. Values: 3 to 16. Default option: undef, except on FreeBSD (on FreeBSD, defaults to 9).

#### `ntpsigndsocket`

Optional. Stdlib::Absolutepath. Sets NTP to sign packets using the socket in the ntpsigndsocket path. Requires NTP to be configured to sign sockets.
Value: Path to the socket directory; for example, for Samba: `usr/local/samba/var/lib/ntp_signd/`. Default value: undef.

#### `package_ensure`

String. Whether to install the NTP package, and what version to install. Values: 'present', 'latest', or a specific version number. Default value: 'present'.

#### `package_manage`

Boolean. Whether to manage the NTP package. Default value: true.

#### `package_name`

Array[String]. Specifies the NTP package to manage. Default value: ['ntp'] (except on AIX and Solaris).

#### `panic`

Optional. Integer[0]. Whether NTP should "panic" in the event of a very large clock skew. Applies only if `tinker` option set to true or if your environment is in a virtual machine. Default value: 0 if environment is virtual, undef in all other cases.

#### `peers`

Array[String]. List of NTP servers with which to synchronise the local clock.

#### `preferred_servers`

Array[String]. Specifies one or more preferred peers. Puppet appends 'prefer' to each matching item in the `servers` array. Default value: [ ].

#### `restrict`

Array[String]. Specifies one or more `restrict` options for the NTP configuration. Puppet prefixes each item with 'restrict', so you need to list only the content of the restriction. Default value for most operating systems:

```
[
  'default kod nomodify notrap nopeer noquery',
  '-6 default kod nomodify notrap nopeer noquery',
  '127.0.0.1',
  '-6 ::1',
]
```

Default value for AIX systems:

```
[
  'default nomodify notrap nopeer noquery',
  '127.0.0.1',
]
```

#### `servers`

Array[String]. Specifies one or more servers to be used as NTP peers. Default value: varies by operating system

#### `service_enable`

Boolean. Whether to enable the NTP service at boot. Default value: true.

#### `service_ensure`

String. Whether the NTP service should be running. Values: 'running' or 'stopped'. Default value: 'running'.

#### `service_manage`

Boolean. Whether to manage the NTP service.  Default value: true.

#### `service_name`

String. The NTP service to manage. Default value: varies by operating system.

#### `service_provider`

String. Which service provider to use for NTP. Default value: 'undef'.

#### `step_tickers_file`

Optional. Stdlib::Absolutepath. Location of the step tickers file on the managed system. Default value: varies by operating system.


####`step_tickers_epp`

Optional. String. Location of the step tickers EPP template file. Default value: varies by operating system. Validation error is thrown if both this and the `step_tickers_template` parameters are specified. 

#### `step_tickers_template`

Optional. String.  Location of the step tickers ERB template file. Default value: varies by operating system. Validation error is thrown if both this and the `step_tickers_epp` parameter are specified.

#### `stepout`

Optional. Integer[0, 65535]. Value for stepout if `tinker` value is true. Valid options: unsigned shortint digit. Default value: undef.

#### `tos`

Boolean. Whether to enable tos options. Default value: false.

#### `tos_minclock`

Optional. Integer[1]. Specifies the minclock tos option. Default value: 3.

#### `tos_minsane`

Optional. Integer[1]. Specifies the minsane tos option. Default value: 1.

#### `tos_floor`

Optional. Integer[1]. Specifies the floor tos option. Default value: 1.

#### `tos_ceiling`

Optional. Integer[1]. Specifies the ceiling tos option. Default value: 15.

#### `tos_cohort`

Variant. Boolean, Integer[0,1]. Specifies the cohort tos option. Valid options: 0 or 1. Default value: 0.

#### `tinker`

Boolean. Whether to enable tinker options. Default value: false.

#### `udlc`

Boolean. Specifies whether to configure NTP to use the undisciplined local clock as a time source. Default value: false.

#### `udlc_stratum`

Optional. Integer[1,15]. Specifies the stratum the server should operate at when using the undisciplined local clock as the time source. This value should be set to no less than 10 if ntpd might be accessible outside your immediate, controlled network. Default value: 10.

## Limitations

This module has been tested on [all PE-supported platforms](https://forge.puppetlabs.com/supported#compat-matrix). Additionally, it is tested (but not supported) on Solaris 10 and Fedora 20-22.

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. Please follow our guidelines when contributing changes.

For more information, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

### Contributors

To see who's already involved, see the [list of contributors.](https://github.com/puppetlabs/puppetlabs-ntp/graphs/contributors)
