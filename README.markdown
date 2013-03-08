ntp
====

[![Build Status](https://travis-ci.org/puppetlabs/puppetlabs-ntp.png?branch=master)](https://travis-ci.org/puppetlabs/puppetlabs-ntp)


Overview
--------

The NTP module installs, configures, and manages the network time service.


Module Description
-------------------

The NTP module allows Puppet to install, configure, and then manage your Network Time Protocol service. The module allows you to setup and manage time settings across many servers from one place. 

Setup
-----

**What NTP affects:**

* package/service/configuration files for NTP
* server settings
	
### Beginning with NTP	

To setup NTP on a server

    class { "ntp":
      servers    => [ 'time.apple.com' ],
      autoupdate => false,
    }

Usage
------

When making changes to your configuration of NTP, you may need to stop and restart the ntp service. To keep the ntp service stopped, pass ensure => stopped to the class:

    class { ntp:
      ensure     => running,
      servers    => [ 'time.apple.com iburst',
                      'pool.ntp.org iburst' , ]
      autoupdate => true,
    }

The `ntp` class has several parameters to assist configuration of the ntp service.

**Parameters within `ntp`**

####`servers`

NTP will use your operating system's default server if this parameter is left unspecified. This parameter accepts an array of servers,
    
    class { 'ntp':
      servers => [ '0.debian.pool.ntp.org iburst',
                   '1.debian.pool.ntp.org iburst',
                   '2.debian.pool.ntp.org iburst',
                   '3.debian.pool.ntp.org iburst', ]
    }

####`restrict`

This parameter specifies whether to restrict ntp daemons from allowing others to use as a server.

####`autoupdate`

This parameter is used to determine whether the ntp package will be updated automatically or not.

####`enable` 

This parameter allows you to choose whether to automatically start ntp daemon on boot.

####`template`

This parameter allows you to explicitly override the template used.


Limitations
------------

This module has been built and tested using Puppet 2.6.x, 2.7, and 3.x.

The module has been tested on:

* Enterprise Linux 5
* Debian 6.0 
* CentOS 5.4.
* Ubuntu 12.04

Testing on other platforms has been light and cannot be guaranteed. 

Development
------------

Puppet Labs modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. We can’t access the huge number of platforms and myriad of hardware, software, and deployment configurations that Puppet is intended to serve.

We want to keep it as easy as possible to contribute changes so that our modules work in your environment. There are a few guidelines that we need contributors to follow so that we can have a chance of keeping on top of things.

You can read the complete module contribution guide [on the Puppet Labs wiki.](http://projects.puppetlabs.com/projects/module-site/wiki/Module_contributing)

Release Notes
--------------

**0.2.0**

0.2.0 is a backwards compatible feature and bug-fix release. Since
0.1.0, support for Amazon Linux was added, fixes for style were
implemented, and support was added for tinker_panic. tinker_panic
will default to on when the fact is_virtual is true.
