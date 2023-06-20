<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v10.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v10.1.0) - 2023-06-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v10.0.0...v10.1.0)

### Added

- pdksync - (MAINT) - Allow Stdlib 9.x [#685](https://github.com/puppetlabs/puppetlabs-ntp/pull/685) ([LukasAud](https://github.com/LukasAud))

## [v10.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v10.0.0) - 2023-04-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v9.2.2...v10.0.0)

### Changed
- (CONT-790) Add Support for Puppet 8 / Drop Support for Puppet 6 [#674](https://github.com/puppetlabs/puppetlabs-ntp/pull/674) ([david22swan](https://github.com/david22swan))

## [v9.2.2](https://github.com/puppetlabs/puppetlabs-ntp/tree/v9.2.2) - 2023-04-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v9.2.1...v9.2.2)

### Fixed

- (CONT-404) Address set-output deprecation [#670](https://github.com/puppetlabs/puppetlabs-ntp/pull/670) ([LukasAud](https://github.com/LukasAud))

## [v9.2.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/v9.2.1) - 2023-02-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v9.2.0...v9.2.1)

### Fixed

- minimum value for poll interval should be 3, not 4 [#665](https://github.com/puppetlabs/puppetlabs-ntp/pull/665) ([johnwarburton](https://github.com/johnwarburton))
- (CONT-360) Syntax update [#663](https://github.com/puppetlabs/puppetlabs-ntp/pull/663) ([LukasAud](https://github.com/LukasAud))
- pdksync - (CONT-189) Remove support for RedHat6 / OracleLinux6 / Scientific6 [#655](https://github.com/puppetlabs/puppetlabs-ntp/pull/655) ([david22swan](https://github.com/david22swan))
- pdksync - (CONT-130) - Dropping Support for Debian 9 [#652](https://github.com/puppetlabs/puppetlabs-ntp/pull/652) ([jordanbreen28](https://github.com/jordanbreen28))

## [v9.2.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v9.2.0) - 2022-08-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v9.1.1...v9.2.0)

### Added

- pdksync - (GH-cat-11) Certify Support for Ubuntu 22.04 [#648](https://github.com/puppetlabs/puppetlabs-ntp/pull/648) ([david22swan](https://github.com/david22swan))

### Fixed

- SMF service instance change in Oracle Solaris 11.4 SRU 45.119.2 [#647](https://github.com/puppetlabs/puppetlabs-ntp/pull/647) ([Kristijan](https://github.com/Kristijan))

## [v9.1.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/v9.1.1) - 2022-06-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v9.1.0...v9.1.1)

### Fixed

- pdksync - (GH-iac-334) Remove Support for Ubuntu 14.04/16.04 [#639](https://github.com/puppetlabs/puppetlabs-ntp/pull/639) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1787) Remove Support for CentOS 6 [#637](https://github.com/puppetlabs/puppetlabs-ntp/pull/637) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1598) - Remove Support for Debian 8 [#635](https://github.com/puppetlabs/puppetlabs-ntp/pull/635) ([david22swan](https://github.com/david22swan))

## [v9.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v9.1.0) - 2021-08-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v9.0.1...v9.1.0)

### Added

- pdksync - (IAC-1709) - Add Support for Debian 11 [#632](https://github.com/puppetlabs/puppetlabs-ntp/pull/632) ([david22swan](https://github.com/david22swan))

### Fixed

- (maint) Allow stdlib 8.0.0 [#633](https://github.com/puppetlabs/puppetlabs-ntp/pull/633) ([smortex](https://github.com/smortex))

## [v9.0.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/v9.0.1) - 2021-03-29

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v9.0.0...v9.0.1)

### Fixed

- Allow setting user and group permissions of the NTP logfile [#615](https://github.com/puppetlabs/puppetlabs-ntp/pull/615) ([Kristijan](https://github.com/Kristijan))

## [v9.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v9.0.0) - 2021-03-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v8.5.0...v9.0.0)

### Changed
- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [#605](https://github.com/puppetlabs/puppetlabs-ntp/pull/605) ([carabasdaniel](https://github.com/carabasdaniel))

## [v8.5.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v8.5.0) - 2020-12-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v8.4.0...v8.5.0)

### Added

- pdksync - (feat) - Add support for Puppet 7 [#594](https://github.com/puppetlabs/puppetlabs-ntp/pull/594) ([daianamezdrea](https://github.com/daianamezdrea))
- (MAINT) Make mode for logfile configurable [#590](https://github.com/puppetlabs/puppetlabs-ntp/pull/590) ([tmanninger](https://github.com/tmanninger))
- (IAC-997) Removal of inappropriate terminology [#587](https://github.com/puppetlabs/puppetlabs-ntp/pull/587) ([pmcmaw](https://github.com/pmcmaw))

## [v8.4.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v8.4.0) - 2020-09-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v8.3.0...v8.4.0)

### Added

- pdksync - (IAC-973) - Update travis/appveyor to run on new default branch `main` [#579](https://github.com/puppetlabs/puppetlabs-ntp/pull/579) ([david22swan](https://github.com/david22swan))
- (IAC-746) - Add ubuntu 20.04 support [#575](https://github.com/puppetlabs/puppetlabs-ntp/pull/575) ([david22swan](https://github.com/david22swan))

## [v8.3.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v8.3.0) - 2020-04-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v8.2.0...v8.3.0)

### Added

- (MAINT) Add Solaris family Hiera data [#554](https://github.com/puppetlabs/puppetlabs-ntp/pull/554) ([paescuj](https://github.com/paescuj))
- pdksync - (FM-8581) - Debian 10 added to travis and provision file refactored [#552](https://github.com/puppetlabs/puppetlabs-ntp/pull/552) ([david22swan](https://github.com/david22swan))
- (MODULES-10413) Allow custom ntp user and daemon options  [#551](https://github.com/puppetlabs/puppetlabs-ntp/pull/551) ([david22swan](https://github.com/david22swan))

## [v8.2.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v8.2.0) - 2019-12-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v8.1.0...v8.2.0)

### Added

- FM-8407 - Add support on Debian 10 [#528](https://github.com/puppetlabs/puppetlabs-ntp/pull/528) ([lionce](https://github.com/lionce))

## [v8.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v8.1.0) - 2019-09-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v8.0.0...v8.1.0)

### Added

- (FM-8188) convert ntp to use litmus [#517](https://github.com/puppetlabs/puppetlabs-ntp/pull/517) ([tphoney](https://github.com/tphoney))

### Fixed

- Fix disable_dhclient [#521](https://github.com/puppetlabs/puppetlabs-ntp/pull/521) ([raphink](https://github.com/raphink))

## [v8.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/v8.0.0) - 2019-05-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/7.4.0...v8.0.0)

### Changed
- pdksync - (MODULES-8444) - Raise lower Puppet bound [#510](https://github.com/puppetlabs/puppetlabs-ntp/pull/510) ([david22swan](https://github.com/david22swan))

### Fixed

- Service hasstatus and hasrestart atributes [#499](https://github.com/puppetlabs/puppetlabs-ntp/pull/499) ([ffapitalle](https://github.com/ffapitalle))

## [7.4.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/7.4.0) - 2019-02-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/7.3.0...7.4.0)

### Added

- (MODULES-8139) - Add SLES 15 support [#492](https://github.com/puppetlabs/puppetlabs-ntp/pull/492) ([eimlav](https://github.com/eimlav))
- (MODULES-8098) - Add logconfig option to config file [#491](https://github.com/puppetlabs/puppetlabs-ntp/pull/491) ([eimlav](https://github.com/eimlav))

### Fixed

- (FM-7719) - Remove Amazon Linux and Arch Linux testing/support for ntp module [#498](https://github.com/puppetlabs/puppetlabs-ntp/pull/498) ([david22swan](https://github.com/david22swan))
- pdksync - (FM-7655) Fix rubygems-update for ruby < 2.3 [#495](https://github.com/puppetlabs/puppetlabs-ntp/pull/495) ([tphoney](https://github.com/tphoney))

## [7.3.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/7.3.0) - 2018-09-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/7.2.0...7.3.0)

### Added

- pdksync - (MODULES-6805) metadata.json shows support for puppet 6 [#484](https://github.com/puppetlabs/puppetlabs-ntp/pull/484) ([tphoney](https://github.com/tphoney))
- Add burst param [#476](https://github.com/puppetlabs/puppetlabs-ntp/pull/476) ([kobybr](https://github.com/kobybr))
- (MODULES-7465) Addition of support for Ubuntu 18.04 to NTP [#475](https://github.com/puppetlabs/puppetlabs-ntp/pull/475) ([david22swan](https://github.com/david22swan))

## [7.2.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/7.2.0) - 2018-07-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/7.1.1...7.2.0)

### Added

- Add SLES 15 hiera data [#472](https://github.com/puppetlabs/puppetlabs-ntp/pull/472) ([mattiascockburn](https://github.com/mattiascockburn))
- (FM-7038) Add support for Debian 9 [#470](https://github.com/puppetlabs/puppetlabs-ntp/pull/470) ([david22swan](https://github.com/david22swan))
- add tos_orphan parameter [#452](https://github.com/puppetlabs/puppetlabs-ntp/pull/452) ([disklord](https://github.com/disklord))

### Changed
- (FM-6955) Remove unsupported OS: F24, F25, Debian 7 [#462](https://github.com/puppetlabs/puppetlabs-ntp/pull/462) ([david22swan](https://github.com/david22swan))

### Fixed

- (MODULES-6363) fix disabling dhclient on redhat-derivatives [#439](https://github.com/puppetlabs/puppetlabs-ntp/pull/439) ([sudodevnull](https://github.com/sudodevnull))

## [7.1.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/7.1.1) - 2018-02-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/7.1.0...7.1.1)

### Other

- (MODULES-6619) - Release Prep 7.1.1 [#447](https://github.com/puppetlabs/puppetlabs-ntp/pull/447) ([pmcmaw](https://github.com/pmcmaw))
- Release 7.1.0 merge back [#446](https://github.com/puppetlabs/puppetlabs-ntp/pull/446) ([pmcmaw](https://github.com/pmcmaw))

## [7.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/7.1.0) - 2018-01-25

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/7.0.0...7.1.0)

### Added

- MODULES-6402: ntp: support xntpd's slewalways  [#442](https://github.com/puppetlabs/puppetlabs-ntp/pull/442) ([k8r-io](https://github.com/k8r-io))

### Other

- reword slewalways setting for clarity [#445](https://github.com/puppetlabs/puppetlabs-ntp/pull/445) ([jbondpdx](https://github.com/jbondpdx))
- (MODULES-6486) - Release prep 7.1.0 [#444](https://github.com/puppetlabs/puppetlabs-ntp/pull/444) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-6326) - PDK convert ntp [#443](https://github.com/puppetlabs/puppetlabs-ntp/pull/443) ([pmcmaw](https://github.com/pmcmaw))
- (maint) modulesync 65530a4 Update Travis [#440](https://github.com/puppetlabs/puppetlabs-ntp/pull/440) ([michaeltlombardi](https://github.com/michaeltlombardi))
- Avoid collision between OS and OS family name [#437](https://github.com/puppetlabs/puppetlabs-ntp/pull/437) ([jonhattan](https://github.com/jonhattan))
- (maint) - modulesync 384f4c1 [#436](https://github.com/puppetlabs/puppetlabs-ntp/pull/436) ([tphoney](https://github.com/tphoney))
- strip data types out of puppet-strings comments [#435](https://github.com/puppetlabs/puppetlabs-ntp/pull/435) ([jbondpdx](https://github.com/jbondpdx))
- FM-6634 fix up rubocop errors [#434](https://github.com/puppetlabs/puppetlabs-ntp/pull/434) ([tphoney](https://github.com/tphoney))
- Make documentation more readable. [#433](https://github.com/puppetlabs/puppetlabs-ntp/pull/433) ([AlexanderSalmin](https://github.com/AlexanderSalmin))
- (maint) -modulesync 1d81b6a [#432](https://github.com/puppetlabs/puppetlabs-ntp/pull/432) ([pmcmaw](https://github.com/pmcmaw))
- Don't use 'inherits' in config, install and service [#431](https://github.com/puppetlabs/puppetlabs-ntp/pull/431) ([antaflos](https://github.com/antaflos))
- 7.0.0 Release back [#430](https://github.com/puppetlabs/puppetlabs-ntp/pull/430) ([pmcmaw](https://github.com/pmcmaw))
- is_virtual fact is boolean and can't be given to str2bool [#421](https://github.com/puppetlabs/puppetlabs-ntp/pull/421) ([zivis](https://github.com/zivis))

## [7.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/7.0.0) - 2017-10-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/6.4.1...7.0.0)

### Other

- (MODULES-5831) - Release Prep for NTP 7.0.0 [#429](https://github.com/puppetlabs/puppetlabs-ntp/pull/429) ([pmcmaw](https://github.com/pmcmaw))
- Update yaml to version 5 [#428](https://github.com/puppetlabs/puppetlabs-ntp/pull/428) ([pmcmaw](https://github.com/pmcmaw))
- 6.4.1 Mergeback from release [#427](https://github.com/puppetlabs/puppetlabs-ntp/pull/427) ([pmcmaw](https://github.com/pmcmaw))

## [6.4.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/6.4.1) - 2017-10-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/6.4.0...6.4.1)

### Other

- Release Prep for 6.4.1 [#426](https://github.com/puppetlabs/puppetlabs-ntp/pull/426) ([pmcmaw](https://github.com/pmcmaw))
- Revert "Update yaml to version 5" [#425](https://github.com/puppetlabs/puppetlabs-ntp/pull/425) ([pmcmaw](https://github.com/pmcmaw))
- Release mergeback 6.4.0 [#424](https://github.com/puppetlabs/puppetlabs-ntp/pull/424) ([pmcmaw](https://github.com/pmcmaw))

## [6.4.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/6.4.0) - 2017-10-25

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/6.3.0...6.4.0)

### Other

- 6.4 Pre-Release [#423](https://github.com/puppetlabs/puppetlabs-ntp/pull/423) ([david22swan](https://github.com/david22swan))
- quick-fix-to-sles [#422](https://github.com/puppetlabs/puppetlabs-ntp/pull/422) ([david22swan](https://github.com/david22swan))
- MODULES-5690: Implementing Rubocop in the module [#418](https://github.com/puppetlabs/puppetlabs-ntp/pull/418) ([david22swan](https://github.com/david22swan))
- (maint) 6.3.0 release merge back [#417](https://github.com/puppetlabs/puppetlabs-ntp/pull/417) ([HAIL9000](https://github.com/HAIL9000))

## [6.3.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/6.3.0) - 2017-10-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/6.2.0...6.3.0)

### Other

- Remove preceding double-colons from example class declarations [#416](https://github.com/puppetlabs/puppetlabs-ntp/pull/416) ([gabe-sky](https://github.com/gabe-sky))
- (FM-6366) release prep for 6.3.0 [#415](https://github.com/puppetlabs/puppetlabs-ntp/pull/415) ([eputnam](https://github.com/eputnam))
- (maint) modulesync 892c4cf [#414](https://github.com/puppetlabs/puppetlabs-ntp/pull/414) ([HAIL9000](https://github.com/HAIL9000))
- Removing unsupported OS [#413](https://github.com/puppetlabs/puppetlabs-ntp/pull/413) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-5501) - Remove unsupported Ubuntu [#412](https://github.com/puppetlabs/puppetlabs-ntp/pull/412) ([pmcmaw](https://github.com/pmcmaw))
- (docs) fix the range for polls in README [#411](https://github.com/puppetlabs/puppetlabs-ntp/pull/411) ([tphoney](https://github.com/tphoney))
- (maint) modulesync 915cde70e20 [#409](https://github.com/puppetlabs/puppetlabs-ntp/pull/409) ([glennsarti](https://github.com/glennsarti))
- Release mergeback 6.2.0 [#408](https://github.com/puppetlabs/puppetlabs-ntp/pull/408) ([HelenCampbell](https://github.com/HelenCampbell))
- Adding tos_maxclock [#407](https://github.com/puppetlabs/puppetlabs-ntp/pull/407) ([tphoney](https://github.com/tphoney))
- cleaning up opensuse default parameters [#406](https://github.com/puppetlabs/puppetlabs-ntp/pull/406) ([tphoney](https://github.com/tphoney))
- (MODULES-5187) mysnc puppet 5 and ruby 2.4 [#405](https://github.com/puppetlabs/puppetlabs-ntp/pull/405) ([eputnam](https://github.com/eputnam))
- (MODULES-5144) Prep for puppet 5 [#404](https://github.com/puppetlabs/puppetlabs-ntp/pull/404) ([hunner](https://github.com/hunner))
- (MODULES-4168) Add option to enable NTP mode7 [#403](https://github.com/puppetlabs/puppetlabs-ntp/pull/403) ([thechristschn](https://github.com/thechristschn))
- MODULES-4827 puppetlabs-ntp: Update the version compatibility to >= 4… [#402](https://github.com/puppetlabs/puppetlabs-ntp/pull/402) ([marsmensch](https://github.com/marsmensch))
- [MODULES-4941] Correct driftfile for SUSE OS [#401](https://github.com/puppetlabs/puppetlabs-ntp/pull/401) ([mcgege](https://github.com/mcgege))
- (maint) - Renaming README extension to .md [#400](https://github.com/puppetlabs/puppetlabs-ntp/pull/400) ([pmcmaw](https://github.com/pmcmaw))
- 6.2.0 Release Mergeback [#399](https://github.com/puppetlabs/puppetlabs-ntp/pull/399) ([pmcmaw](https://github.com/pmcmaw))
- Update yaml to version 5 [#394](https://github.com/puppetlabs/puppetlabs-ntp/pull/394) ([danielhoherd](https://github.com/danielhoherd))
- allow monitor disabled while setting stat properties [#393](https://github.com/puppetlabs/puppetlabs-ntp/pull/393) ([cqwense](https://github.com/cqwense))
- Update ntp.conf.epp [#392](https://github.com/puppetlabs/puppetlabs-ntp/pull/392) ([bojleros](https://github.com/bojleros))
- Update permissions on the keys file [#381](https://github.com/puppetlabs/puppetlabs-ntp/pull/381) ([dan-nawrocki](https://github.com/dan-nawrocki))

## [6.2.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/6.2.0) - 2017-05-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/6.1.0...6.2.0)

### Other

- release prep for 6.2.0 [#398](https://github.com/puppetlabs/puppetlabs-ntp/pull/398) ([eputnam](https://github.com/eputnam))
- Fix for the controlkey issue breaking SLES test [#397](https://github.com/puppetlabs/puppetlabs-ntp/pull/397) ([HelenCampbell](https://github.com/HelenCampbell))
- Add missing spaces to README.markdown [#396](https://github.com/puppetlabs/puppetlabs-ntp/pull/396) ([smortex](https://github.com/smortex))
- updated Japanese readme [#395](https://github.com/puppetlabs/puppetlabs-ntp/pull/395) ([jbondpdx](https://github.com/jbondpdx))
- Release 6.1.0 mergeback [#391](https://github.com/puppetlabs/puppetlabs-ntp/pull/391) ([pmcmaw](https://github.com/pmcmaw))
- (FM-6137) - Adding tests and docs for 'pool' [#390](https://github.com/puppetlabs/puppetlabs-ntp/pull/390) ([pmcmaw](https://github.com/pmcmaw))

## [6.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/6.1.0) - 2017-04-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/6.0.0...6.1.0)

### Added

- (MODULES-4647) - Adding a Japanese translated po file and README [#387](https://github.com/puppetlabs/puppetlabs-ntp/pull/387) ([pmcmaw](https://github.com/pmcmaw))
- Added pool support [#377](https://github.com/puppetlabs/puppetlabs-ntp/pull/377) ([gknight007](https://github.com/gknight007))
- (MODULES-4414) Allow NTP statistics if requested [#375](https://github.com/puppetlabs/puppetlabs-ntp/pull/375) ([jcpunk](https://github.com/jcpunk))
- Implement beaker-module_install_helper and cleanup spec_helper_acceptance.rb [#370](https://github.com/puppetlabs/puppetlabs-ntp/pull/370) ([wilson208](https://github.com/wilson208))
- MODULES-4278 - NTP module noselect feature [#367](https://github.com/puppetlabs/puppetlabs-ntp/pull/367) ([jcpunk](https://github.com/jcpunk))

### Fixed

- add missing fedora versions to metadata.json [#386](https://github.com/puppetlabs/puppetlabs-ntp/pull/386) ([bastelfreak](https://github.com/bastelfreak))
- add archlinux to metadata.json [#384](https://github.com/puppetlabs/puppetlabs-ntp/pull/384) ([bastelfreak](https://github.com/bastelfreak))
- [MODULES-4528] Replace Puppet.version.to_f version comparison from spec_helper.rb [#382](https://github.com/puppetlabs/puppetlabs-ntp/pull/382) ([wilson208](https://github.com/wilson208))
- (maint) change service_ensure data type to Enum [#374](https://github.com/puppetlabs/puppetlabs-ntp/pull/374) ([vchepkov](https://github.com/vchepkov))
- (MODULES-3396) remove superfluous empty lines in ntp.conf [#373](https://github.com/puppetlabs/puppetlabs-ntp/pull/373) ([vchepkov](https://github.com/vchepkov))
- add xenial to metadata [#363](https://github.com/puppetlabs/puppetlabs-ntp/pull/363) ([eputnam](https://github.com/eputnam))

### Other

- (FM-6133) - NTP 6.1.0 Release Prep [#389](https://github.com/puppetlabs/puppetlabs-ntp/pull/389) ([pmcmaw](https://github.com/pmcmaw))
- [msync] 786266 Implement puppet-module-gems, a45803 Remove metadata.json from locales config [#385](https://github.com/puppetlabs/puppetlabs-ntp/pull/385) ([wilson208](https://github.com/wilson208))
- (FM-6116) - Adding POT file for metadata.json [#383](https://github.com/puppetlabs/puppetlabs-ntp/pull/383) ([pmcmaw](https://github.com/pmcmaw))
- Removing an extra quote from the README [#380](https://github.com/puppetlabs/puppetlabs-ntp/pull/380) ([pmcmaw](https://github.com/pmcmaw))
- Remove anchor comment [#376](https://github.com/puppetlabs/puppetlabs-ntp/pull/376) ([DavidS](https://github.com/DavidS))
- (maint) Delete misleading comment [#372](https://github.com/puppetlabs/puppetlabs-ntp/pull/372) ([hunner](https://github.com/hunner))
- edit for localization [#371](https://github.com/puppetlabs/puppetlabs-ntp/pull/371) ([jbondpdx](https://github.com/jbondpdx))
- (MODULES-4098) Sync the rest of the files [#369](https://github.com/puppetlabs/puppetlabs-ntp/pull/369) ([hunner](https://github.com/hunner))
- (MODULES-4225) add strings to ntp module [#366](https://github.com/puppetlabs/puppetlabs-ntp/pull/366) ([jbondpdx](https://github.com/jbondpdx))
- (MODULES-4097) Sync travis.yml [#364](https://github.com/puppetlabs/puppetlabs-ntp/pull/364) ([hunner](https://github.com/hunner))
- (MODULES-3397) fix default Solaris settings [#362](https://github.com/puppetlabs/puppetlabs-ntp/pull/362) ([vchepkov](https://github.com/vchepkov))
- Reverse Solaris-11 and Solaris transpose fix [#360](https://github.com/puppetlabs/puppetlabs-ntp/pull/360) ([pearcec](https://github.com/pearcec))
- Loc+ strings edit [#359](https://github.com/puppetlabs/puppetlabs-ntp/pull/359) ([jbondpdx](https://github.com/jbondpdx))
- (FM-5972) gettext and spec.opts [#358](https://github.com/puppetlabs/puppetlabs-ntp/pull/358) ([eputnam](https://github.com/eputnam))
- (MODULES-3631) msync Gemfile for 1.9 frozen strings [#357](https://github.com/puppetlabs/puppetlabs-ntp/pull/357) ([hunner](https://github.com/hunner))
- (MODULES-3704) Update gemfile template to be identical [#354](https://github.com/puppetlabs/puppetlabs-ntp/pull/354) ([hunner](https://github.com/hunner))
- Release 6.0.0 mergeback [#353](https://github.com/puppetlabs/puppetlabs-ntp/pull/353) ([bmjen](https://github.com/bmjen))
- (MODULES-3983) Update parallel_tests for ruby 2.0.0 [#350](https://github.com/puppetlabs/puppetlabs-ntp/pull/350) ([pmcmaw](https://github.com/pmcmaw))

## [6.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/6.0.0) - 2016-11-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/5.0.0...6.0.0)

### Other

- Release 5.0.0 mergeback [#352](https://github.com/puppetlabs/puppetlabs-ntp/pull/352) ([bmjen](https://github.com/bmjen))
- Remove deprecated functionality and prep for 6.0.0 release [#332](https://github.com/puppetlabs/puppetlabs-ntp/pull/332) ([DavidS](https://github.com/DavidS))

## [5.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/5.0.0) - 2016-10-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/4.2.0...5.0.0)

### Other

- Release fixes [#351](https://github.com/puppetlabs/puppetlabs-ntp/pull/351) ([DavidS](https://github.com/DavidS))
- Revert changes to spec_helper_acceptance [#349](https://github.com/puppetlabs/puppetlabs-ntp/pull/349) ([DavidS](https://github.com/DavidS))
- Add a link to the blogpost to the CHANGELOG [#348](https://github.com/puppetlabs/puppetlabs-ntp/pull/348) ([DavidS](https://github.com/DavidS))
- (FM-5598) NTP 5.0.0 features and release-prep [#346](https://github.com/puppetlabs/puppetlabs-ntp/pull/346) ([DavidS](https://github.com/DavidS))
- MODULES-3898 - ntp step-tickers should honor preferred servers [#345](https://github.com/puppetlabs/puppetlabs-ntp/pull/345) ([jcpunk](https://github.com/jcpunk))
- Remove path to template file from keys.erb [#344](https://github.com/puppetlabs/puppetlabs-ntp/pull/344) ([tdevelioglu](https://github.com/tdevelioglu))
- [MAINT] Update README to amend incorrect package_name description [#342](https://github.com/puppetlabs/puppetlabs-ntp/pull/342) ([wilson208](https://github.com/wilson208))
- Update modulesync_config [a3fe424] [#341](https://github.com/puppetlabs/puppetlabs-ntp/pull/341) ([DavidS](https://github.com/DavidS))
- (MAINT) Update NOTICE to new company name [#340](https://github.com/puppetlabs/puppetlabs-ntp/pull/340) ([DavidS](https://github.com/DavidS))
- (FM-5470) add is reset-failed for systemd, on test [#337](https://github.com/puppetlabs/puppetlabs-ntp/pull/337) ([tphoney](https://github.com/tphoney))
- (MAINT) Update for modulesync_config 72d19f184 [#336](https://github.com/puppetlabs/puppetlabs-ntp/pull/336) ([DavidS](https://github.com/DavidS))
- (MODULES-3581) modulesync [067d08a] [#334](https://github.com/puppetlabs/puppetlabs-ntp/pull/334) ([DavidS](https://github.com/DavidS))
- {maint} modulesync 0794b2c [#333](https://github.com/puppetlabs/puppetlabs-ntp/pull/333) ([tphoney](https://github.com/tphoney))
- Cleanups [#331](https://github.com/puppetlabs/puppetlabs-ntp/pull/331) ([DavidS](https://github.com/DavidS))
- 4.2.x Mergeback [#330](https://github.com/puppetlabs/puppetlabs-ntp/pull/330) ([HelenCampbell](https://github.com/HelenCampbell))
- Step tickers [#329](https://github.com/puppetlabs/puppetlabs-ntp/pull/329) ([jonnytdevops](https://github.com/jonnytdevops))

## [4.2.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/4.2.0) - 2016-05-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/4.1.2...4.2.0)

### Other

- editorial changes for ntp 4.2.x release [#327](https://github.com/puppetlabs/puppetlabs-ntp/pull/327) ([jbondpdx](https://github.com/jbondpdx))
- Update README.markdown [#326](https://github.com/puppetlabs/puppetlabs-ntp/pull/326) ([braddeicide](https://github.com/braddeicide))
- Release prep for 4.2.0 [#325](https://github.com/puppetlabs/puppetlabs-ntp/pull/325) ([HelenCampbell](https://github.com/HelenCampbell))
- Update to newest modulesync_configs [9ca280f] [#324](https://github.com/puppetlabs/puppetlabs-ntp/pull/324) ([DavidS](https://github.com/DavidS))
- (maint) fix test to run under strict variables [#323](https://github.com/puppetlabs/puppetlabs-ntp/pull/323) ([tphoney](https://github.com/tphoney))
- Demonstrate adding beaker acceptance tests to a module [#320](https://github.com/puppetlabs/puppetlabs-ntp/pull/320) ([garethr](https://github.com/garethr))
- Special case for solaris too [#319](https://github.com/puppetlabs/puppetlabs-ntp/pull/319) ([hunner](https://github.com/hunner))
- Update the spec for the new default keys [#318](https://github.com/puppetlabs/puppetlabs-ntp/pull/318) ([hunner](https://github.com/hunner))
- Use config_dir for keys_file [#317](https://github.com/puppetlabs/puppetlabs-ntp/pull/317) ([hunner](https://github.com/hunner))
- fix directory permissions and some quotes in manifests/config.pp [#316](https://github.com/puppetlabs/puppetlabs-ntp/pull/316) ([n0wi](https://github.com/n0wi))
- add key distribution [#314](https://github.com/puppetlabs/puppetlabs-ntp/pull/314) ([n0wi](https://github.com/n0wi))
- Work for SLES 12 compatibility [#312](https://github.com/puppetlabs/puppetlabs-ntp/pull/312) ([HelenCampbell](https://github.com/HelenCampbell))
- Update metadata to note Debian 8 support [#311](https://github.com/puppetlabs/puppetlabs-ntp/pull/311) ([DavidS](https://github.com/DavidS))
- (FM-4046) Update to current msync configs [006831f] [#310](https://github.com/puppetlabs/puppetlabs-ntp/pull/310) ([DavidS](https://github.com/DavidS))
- Update to readme and test for key params [#308](https://github.com/puppetlabs/puppetlabs-ntp/pull/308) ([HelenCampbell](https://github.com/HelenCampbell))
- (FM-4049) update to modulesync_configs [#307](https://github.com/puppetlabs/puppetlabs-ntp/pull/307) ([DavidS](https://github.com/DavidS))
- Add support for the authprov parameter [#306](https://github.com/puppetlabs/puppetlabs-ntp/pull/306) ([cholyoak](https://github.com/cholyoak))
- Add parameter for interfaces to ignore [#305](https://github.com/puppetlabs/puppetlabs-ntp/pull/305) ([aptituz](https://github.com/aptituz))
- Enabled usage of the $ntpsigndsocket parameter, for socket signing. [#304](https://github.com/puppetlabs/puppetlabs-ntp/pull/304) ([powertoaster](https://github.com/powertoaster))
- Adding bug workaround in tests for Debian 8 [#302](https://github.com/puppetlabs/puppetlabs-ntp/pull/302) ([HelenCampbell](https://github.com/HelenCampbell))
- 4.1.x Mergeback [#301](https://github.com/puppetlabs/puppetlabs-ntp/pull/301) ([HelenCampbell](https://github.com/HelenCampbell))

## [4.1.2](https://github.com/puppetlabs/puppetlabs-ntp/tree/4.1.2) - 2015-12-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/4.1.1...4.1.2)

### Other

- 4.1.2 release prep [#299](https://github.com/puppetlabs/puppetlabs-ntp/pull/299) ([tphoney](https://github.com/tphoney))

## [4.1.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/4.1.1) - 2015-11-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/4.1.0...4.1.1)

### Other

- enhanced default configuration [#297](https://github.com/puppetlabs/puppetlabs-ntp/pull/297) ([bmjen](https://github.com/bmjen))
- (FM-3815) Parameterize file mode of config file. [#296](https://github.com/puppetlabs/puppetlabs-ntp/pull/296) ([bmjen](https://github.com/bmjen))
- Convert license string to SPDX format [#295](https://github.com/puppetlabs/puppetlabs-ntp/pull/295) ([mschwager](https://github.com/mschwager))
- Fix MODULES-1790 [#294](https://github.com/puppetlabs/puppetlabs-ntp/pull/294) ([Thubo](https://github.com/Thubo))
- Add disable_dhclient parameter [#293](https://github.com/puppetlabs/puppetlabs-ntp/pull/293) ([raphink](https://github.com/raphink))
- Fix management of etc and unit test runtime [#292](https://github.com/puppetlabs/puppetlabs-ntp/pull/292) ([DavidS](https://github.com/DavidS))
- Adding ::operatingsystem Amazon for Facter < 1.7.0 (cloud-init installs 1.6.18) [#291](https://github.com/puppetlabs/puppetlabs-ntp/pull/291) ([dmcnaught](https://github.com/dmcnaught))
- Update Solaris support for newer Facter [#290](https://github.com/puppetlabs/puppetlabs-ntp/pull/290) ([zachfi](https://github.com/zachfi))
- fix for tos settings in ntp.conf template and spec file [#289](https://github.com/puppetlabs/puppetlabs-ntp/pull/289) ([lvlie](https://github.com/lvlie))
- (#2282) Add support for 'disable kernel' [#288](https://github.com/puppetlabs/puppetlabs-ntp/pull/288) ([mikebryant](https://github.com/mikebryant))
- 4.1.x Mergeback to master [#287](https://github.com/puppetlabs/puppetlabs-ntp/pull/287) ([bmjen](https://github.com/bmjen))
- MODULES-2210 Add TOS Parameter [#282](https://github.com/puppetlabs/puppetlabs-ntp/pull/282) ([petems](https://github.com/petems))
- enhanced default configuration [#194](https://github.com/puppetlabs/puppetlabs-ntp/pull/194) ([sebastianschauenburg](https://github.com/sebastianschauenburg))

## [4.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/4.1.0) - 2015-07-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/4.0.0...4.1.0)

### Other

- update changelog [#286](https://github.com/puppetlabs/puppetlabs-ntp/pull/286) ([bmjen](https://github.com/bmjen))
- Revert "- add Solaris 12 support" [#285](https://github.com/puppetlabs/puppetlabs-ntp/pull/285) ([bmjen](https://github.com/bmjen))
- Release 4.1.0 prep [#284](https://github.com/puppetlabs/puppetlabs-ntp/pull/284) ([bmjen](https://github.com/bmjen))
- Fix CI for PE.next [#283](https://github.com/puppetlabs/puppetlabs-ntp/pull/283) ([DavidS](https://github.com/DavidS))
- Add Solaris 10 Support [#277](https://github.com/puppetlabs/puppetlabs-ntp/pull/277) ([Reamer](https://github.com/Reamer))
- Ensure the log file is created before the service is started/configured. [#276](https://github.com/puppetlabs/puppetlabs-ntp/pull/276) ([jonnytdevops](https://github.com/jonnytdevops))
- - add Solaris 12 support [#274](https://github.com/puppetlabs/puppetlabs-ntp/pull/274) ([drewfisher314](https://github.com/drewfisher314))
- Typo of install method [#273](https://github.com/puppetlabs/puppetlabs-ntp/pull/273) ([hunner](https://github.com/hunner))
- fedora support [#272](https://github.com/puppetlabs/puppetlabs-ntp/pull/272) ([jhoblitt](https://github.com/jhoblitt))
- Add helper to install puppet/pe/puppet-agent [#271](https://github.com/puppetlabs/puppetlabs-ntp/pull/271) ([hunner](https://github.com/hunner))
- (maint) allow setting PUPPET_VERSION in acceptance [#270](https://github.com/puppetlabs/puppetlabs-ntp/pull/270) ([justinstoller](https://github.com/justinstoller))
- Updated travisci file for Puppet 4 [#269](https://github.com/puppetlabs/puppetlabs-ntp/pull/269) ([jonnytdevops](https://github.com/jonnytdevops))
- (MODULES-2087) fix debian default config [#268](https://github.com/puppetlabs/puppetlabs-ntp/pull/268) ([DavidS](https://github.com/DavidS))
- Correct the description of the disable_monitor parameter [#267](https://github.com/puppetlabs/puppetlabs-ntp/pull/267) ([mysteq](https://github.com/mysteq))
- Release Prep 4.0.0 [#266](https://github.com/puppetlabs/puppetlabs-ntp/pull/266) ([jonnytdevops](https://github.com/jonnytdevops))
- Update Arch Linux defaults [#265](https://github.com/puppetlabs/puppetlabs-ntp/pull/265) ([mmonaco](https://github.com/mmonaco))

## [4.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/4.0.0) - 2015-05-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.3.0...4.0.0)

### Changed
- Bump stdlib to 4.5.0 [#248](https://github.com/puppetlabs/puppetlabs-ntp/pull/248) ([hunner](https://github.com/hunner))
- No Undisciplined Local Clock by default [#247](https://github.com/puppetlabs/puppetlabs-ntp/pull/247) ([hunner](https://github.com/hunner))

### Other

- Modulesync updates [#264](https://github.com/puppetlabs/puppetlabs-ntp/pull/264) ([underscorgan](https://github.com/underscorgan))
- adds fix for redhat to disable ntp restart due to dhcp ntp server updates [#262](https://github.com/puppetlabs/puppetlabs-ntp/pull/262) ([bmjen](https://github.com/bmjen))
- fixes debian-based flakiness in acceptance tests [#261](https://github.com/puppetlabs/puppetlabs-ntp/pull/261) ([bmjen](https://github.com/bmjen))
- Leapfile fix [#260](https://github.com/puppetlabs/puppetlabs-ntp/pull/260) ([tphoney](https://github.com/tphoney))
- Added dependency on stdlib 4.6.0 [#258](https://github.com/puppetlabs/puppetlabs-ntp/pull/258) ([underscorgan](https://github.com/underscorgan))
- PR #255 added a dependency on stdlib >= 4.6.0 [#257](https://github.com/puppetlabs/puppetlabs-ntp/pull/257) ([underscorgan](https://github.com/underscorgan))
- Add ntp stepout, minpoll and maxpoll options [#255](https://github.com/puppetlabs/puppetlabs-ntp/pull/255) ([sorrowless](https://github.com/sorrowless))
- (MODULES-1837) Make udlc stratum configurable [#254](https://github.com/puppetlabs/puppetlabs-ntp/pull/254) ([juniorsysadmin](https://github.com/juniorsysadmin))
- MODULES-1836 - Added support for peers [#253](https://github.com/puppetlabs/puppetlabs-ntp/pull/253) ([underscorgan](https://github.com/underscorgan))
- (BKR-147) add Gemfile setting for BEAKER_VERSION for puppet... [#252](https://github.com/puppetlabs/puppetlabs-ntp/pull/252) ([anodelman](https://github.com/anodelman))
- Test updates and lint fixes [#251](https://github.com/puppetlabs/puppetlabs-ntp/pull/251) ([cmurphy](https://github.com/cmurphy))
- Add fudge option [#246](https://github.com/puppetlabs/puppetlabs-ntp/pull/246) ([hunner](https://github.com/hunner))
- (MODULES-1796) Fix stdlib 3.2.0 compatibility [#245](https://github.com/puppetlabs/puppetlabs-ntp/pull/245) ([hunner](https://github.com/hunner))
- Update to debian wheezy defaults [#244](https://github.com/puppetlabs/puppetlabs-ntp/pull/244) ([hunner](https://github.com/hunner))
- Fix PR #235 and make udlc configurable [#243](https://github.com/puppetlabs/puppetlabs-ntp/pull/243) ([hunner](https://github.com/hunner))
- Update the README Table of Contents [#242](https://github.com/puppetlabs/puppetlabs-ntp/pull/242) ([psoloway](https://github.com/psoloway))
- Updates the README file [#241](https://github.com/puppetlabs/puppetlabs-ntp/pull/241) ([psoloway](https://github.com/psoloway))
- Pin rspec gems [#240](https://github.com/puppetlabs/puppetlabs-ntp/pull/240) ([cmurphy](https://github.com/cmurphy))
- Broadcast and auth [#238](https://github.com/puppetlabs/puppetlabs-ntp/pull/238) ([mpuel](https://github.com/mpuel))
- These tests are better covered by the existing unit tests. [#236](https://github.com/puppetlabs/puppetlabs-ntp/pull/236) ([hunner](https://github.com/hunner))
- fix `is_virtual` detection issue [#235](https://github.com/puppetlabs/puppetlabs-ntp/pull/235) ([guessi](https://github.com/guessi))
- extend Readme for a simple client [#234](https://github.com/puppetlabs/puppetlabs-ntp/pull/234) ([bastelfreak](https://github.com/bastelfreak))
- (MODULES-1479) Add package_manage parameter [#233](https://github.com/puppetlabs/puppetlabs-ntp/pull/233) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Fixing logfile parameter. [#232](https://github.com/puppetlabs/puppetlabs-ntp/pull/232) ([jamesdobson](https://github.com/jamesdobson))
- Add IntelliJ files to the ignore list [#229](https://github.com/puppetlabs/puppetlabs-ntp/pull/229) ([cmurphy](https://github.com/cmurphy))
- Update .travis.yml, Gemfile, Rakefile, and CONTRIBUTING.md [#228](https://github.com/puppetlabs/puppetlabs-ntp/pull/228) ([cmurphy](https://github.com/cmurphy))
- Add metadata summary per FM-1523 [#227](https://github.com/puppetlabs/puppetlabs-ntp/pull/227) ([lrnrthr](https://github.com/lrnrthr))
- There are no setup-requirements for puppetlabs-ntp [#226](https://github.com/puppetlabs/puppetlabs-ntp/pull/226) ([underscorgan](https://github.com/underscorgan))
- merge 3.3.x into master [#225](https://github.com/puppetlabs/puppetlabs-ntp/pull/225) ([underscorgan](https://github.com/underscorgan))

## [3.3.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.3.0) - 2014-11-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.2.1...3.3.0)

### Other

- Add support for solaris given the ssl cert issue [#224](https://github.com/puppetlabs/puppetlabs-ntp/pull/224) ([cyberious](https://github.com/cyberious))
- stdlib installation wasn't working [#223](https://github.com/puppetlabs/puppetlabs-ntp/pull/223) ([underscorgan](https://github.com/underscorgan))
- Limitations were out of date. [#222](https://github.com/puppetlabs/puppetlabs-ntp/pull/222) ([underscorgan](https://github.com/underscorgan))
- Updated testing and support for sles12 [#221](https://github.com/puppetlabs/puppetlabs-ntp/pull/221) ([underscorgan](https://github.com/underscorgan))
- Updated testing and support for sles12 [#220](https://github.com/puppetlabs/puppetlabs-ntp/pull/220) ([cyberious](https://github.com/cyberious))
- 3.3.0 prep [#219](https://github.com/puppetlabs/puppetlabs-ntp/pull/219) ([underscorgan](https://github.com/underscorgan))
- Merge 3.2.x into master [#218](https://github.com/puppetlabs/puppetlabs-ntp/pull/218) ([underscorgan](https://github.com/underscorgan))
- Add SLES12 support as it has changed to Systemd [#217](https://github.com/puppetlabs/puppetlabs-ntp/pull/217) ([cyberious](https://github.com/cyberious))
- Merge 3.2.x into master [#216](https://github.com/puppetlabs/puppetlabs-ntp/pull/216) ([underscorgan](https://github.com/underscorgan))

## [3.2.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.2.1) - 2014-10-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.2.0...3.2.1)

### Other

- Missed some EL7 platforms [#215](https://github.com/puppetlabs/puppetlabs-ntp/pull/215) ([underscorgan](https://github.com/underscorgan))
- 3.2.1 prep [#214](https://github.com/puppetlabs/puppetlabs-ntp/pull/214) ([underscorgan](https://github.com/underscorgan))
- Remove recursion, this can expose sensitive information. [#212](https://github.com/puppetlabs/puppetlabs-ntp/pull/212) ([erinn](https://github.com/erinn))
- Merge 3.2.x back into master [#210](https://github.com/puppetlabs/puppetlabs-ntp/pull/210) ([underscorgan](https://github.com/underscorgan))

## [3.2.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.2.0) - 2014-09-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.1.2...3.2.0)

### Other

- Doesn't work on sol10 [#211](https://github.com/puppetlabs/puppetlabs-ntp/pull/211) ([underscorgan](https://github.com/underscorgan))
- Use puppet('module install puppetlabs-stdlib') [#209](https://github.com/puppetlabs/puppetlabs-ntp/pull/209) ([underscorgan](https://github.com/underscorgan))
- Missed interfaces parameter in the README. [#208](https://github.com/puppetlabs/puppetlabs-ntp/pull/208) ([underscorgan](https://github.com/underscorgan))
- Fix for Suse osfamily [#207](https://github.com/puppetlabs/puppetlabs-ntp/pull/207) ([underscorgan](https://github.com/underscorgan))
- Use scp to install the module [#206](https://github.com/puppetlabs/puppetlabs-ntp/pull/206) ([underscorgan](https://github.com/underscorgan))
- Get rid of some extra whitespace in the template [#205](https://github.com/puppetlabs/puppetlabs-ntp/pull/205) ([underscorgan](https://github.com/underscorgan))
- Test fixes for Solaris [#204](https://github.com/puppetlabs/puppetlabs-ntp/pull/204) ([underscorgan](https://github.com/underscorgan))
- Switch over to using puppet() [#202](https://github.com/puppetlabs/puppetlabs-ntp/pull/202) ([underscorgan](https://github.com/underscorgan))
- Fix issue with puppet_module_install, removed and using updated method f... [#201](https://github.com/puppetlabs/puppetlabs-ntp/pull/201) ([cyberious](https://github.com/cyberious))
- 3.2.0 prep [#200](https://github.com/puppetlabs/puppetlabs-ntp/pull/200) ([underscorgan](https://github.com/underscorgan))
- Merge 3.1.x into master [#198](https://github.com/puppetlabs/puppetlabs-ntp/pull/198) ([underscorgan](https://github.com/underscorgan))
- Remove dependency on stdlib4 [#197](https://github.com/puppetlabs/puppetlabs-ntp/pull/197) ([underscorgan](https://github.com/underscorgan))
- Merge 3.1.x into master [#196](https://github.com/puppetlabs/puppetlabs-ntp/pull/196) ([underscorgan](https://github.com/underscorgan))
- Update spec_helper for more consistency [#193](https://github.com/puppetlabs/puppetlabs-ntp/pull/193) ([underscorgan](https://github.com/underscorgan))
- Synchronize with modulesync [#192](https://github.com/puppetlabs/puppetlabs-ntp/pull/192) ([cmurphy](https://github.com/cmurphy))
- Fix acceptance tests for ntp iburst addition [#190](https://github.com/puppetlabs/puppetlabs-ntp/pull/190) ([cyberious](https://github.com/cyberious))
- add fix and tests for strict_variables [#189](https://github.com/puppetlabs/puppetlabs-ntp/pull/189) ([saimonn](https://github.com/saimonn))
- Add support for iburst option [#188](https://github.com/puppetlabs/puppetlabs-ntp/pull/188) ([nanliu](https://github.com/nanliu))
- Fix issue with different solaris osrelease [#186](https://github.com/puppetlabs/puppetlabs-ntp/pull/186) ([nanliu](https://github.com/nanliu))
- ntp is not supported on osx [#185](https://github.com/puppetlabs/puppetlabs-ntp/pull/185) ([justinstoller](https://github.com/justinstoller))
- Re-add default package name, remove Solaris from unsupported platforms. [#184](https://github.com/puppetlabs/puppetlabs-ntp/pull/184) ([underscorgan](https://github.com/underscorgan))
- fix up mistake in setup [#182](https://github.com/puppetlabs/puppetlabs-ntp/pull/182) ([justinstoller](https://github.com/justinstoller))
- Various test setup fixes [#181](https://github.com/puppetlabs/puppetlabs-ntp/pull/181) ([justinstoller](https://github.com/justinstoller))
- Modernize restrict test [#180](https://github.com/puppetlabs/puppetlabs-ntp/pull/180) ([hunner](https://github.com/hunner))
- Capture back metadata.json reformating [#178](https://github.com/puppetlabs/puppetlabs-ntp/pull/178) ([cyberious](https://github.com/cyberious))
- Add Solaris 11 support. [#177](https://github.com/puppetlabs/puppetlabs-ntp/pull/177) ([ody](https://github.com/ody))

## [3.1.2](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.1.2) - 2014-07-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.1.1...3.1.2)

### Other

- Prepare a 3.1.2 release. [#176](https://github.com/puppetlabs/puppetlabs-ntp/pull/176) ([apenney](https://github.com/apenney))
- Add validate and lint tasks to travis script [#175](https://github.com/puppetlabs/puppetlabs-ntp/pull/175) ([cmurphy](https://github.com/cmurphy))
- Synchronize .travis.yml [#174](https://github.com/puppetlabs/puppetlabs-ntp/pull/174) ([cmurphy](https://github.com/cmurphy))
- Start synchronizing module files [#173](https://github.com/puppetlabs/puppetlabs-ntp/pull/173) ([cmurphy](https://github.com/cmurphy))
- (MODULES-213) Solaris 10 support [#172](https://github.com/puppetlabs/puppetlabs-ntp/pull/172) ([hunner](https://github.com/hunner))
- Enable the ability to set interfaces [#170](https://github.com/puppetlabs/puppetlabs-ntp/pull/170) ([matthewfischer](https://github.com/matthewfischer))
- Use contain_class instead of include_class. [#168](https://github.com/puppetlabs/puppetlabs-ntp/pull/168) ([underscorgan](https://github.com/underscorgan))
- Fix typo [#166](https://github.com/puppetlabs/puppetlabs-ntp/pull/166) ([underscorgan](https://github.com/underscorgan))
- Pin rspec to ~> 2.11 [#164](https://github.com/puppetlabs/puppetlabs-ntp/pull/164) ([cyberious](https://github.com/cyberious))

## [3.1.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.1.1) - 2014-06-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.1.0...3.1.1)

### Other

- 3.1.1 prep [#163](https://github.com/puppetlabs/puppetlabs-ntp/pull/163) ([underscorgan](https://github.com/underscorgan))

## [3.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.1.0) - 2014-06-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.0.4...3.1.0)

### Other

- 3.1.0 prep [#162](https://github.com/puppetlabs/puppetlabs-ntp/pull/162) ([underscorgan](https://github.com/underscorgan))
- Dedup params [#160](https://github.com/puppetlabs/puppetlabs-ntp/pull/160) ([cyberious](https://github.com/cyberious))
- merge Master back up to 3.1.x [#159](https://github.com/puppetlabs/puppetlabs-ntp/pull/159) ([cyberious](https://github.com/cyberious))
- Update tests to ignore warnings but still look for errors [#158](https://github.com/puppetlabs/puppetlabs-ntp/pull/158) ([cyberious](https://github.com/cyberious))
- merge 3.1.x down to master [#157](https://github.com/puppetlabs/puppetlabs-ntp/pull/157) ([cyberious](https://github.com/cyberious))
- 3.1.0 prep [#155](https://github.com/puppetlabs/puppetlabs-ntp/pull/155) ([underscorgan](https://github.com/underscorgan))
- Tighten the dependency to > 4.0 for stdlib. [#152](https://github.com/puppetlabs/puppetlabs-ntp/pull/152) ([apenney](https://github.com/apenney))
- Add RHel7 and Ubuntu 14.04 under supported for in metadata.json [#151](https://github.com/puppetlabs/puppetlabs-ntp/pull/151) ([cyberious](https://github.com/cyberious))
- Fix spec_helper_acceptance to work on Ubuntu 14.04. [#150](https://github.com/puppetlabs/puppetlabs-ntp/pull/150) ([underscorgan](https://github.com/underscorgan))
- Typo fix. [#149](https://github.com/puppetlabs/puppetlabs-ntp/pull/149) ([apenney](https://github.com/apenney))
- Fix spec deprecation warnings for include_class [#147](https://github.com/puppetlabs/puppetlabs-ntp/pull/147) ([supercow](https://github.com/supercow))
- add parameter to set a log file [#122](https://github.com/puppetlabs/puppetlabs-ntp/pull/122) ([darix](https://github.com/darix))
- fix documentation - manage_service -> service_manage [#117](https://github.com/puppetlabs/puppetlabs-ntp/pull/117) ([CpuID](https://github.com/CpuID))

## [3.0.4](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.0.4) - 2014-04-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.0.3...3.0.4)

### Other

- Test [#143](https://github.com/puppetlabs/puppetlabs-ntp/pull/143) ([apenney](https://github.com/apenney))
- Fix for AIX machines with IPv6 disabled. [#142](https://github.com/puppetlabs/puppetlabs-ntp/pull/142) ([apenney](https://github.com/apenney))
- Remove autorelease [#140](https://github.com/puppetlabs/puppetlabs-ntp/pull/140) ([hunner](https://github.com/hunner))

## [3.0.3](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.0.3) - 2014-03-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.0.2...3.0.3)

### Other

- Patch metadata [#139](https://github.com/puppetlabs/puppetlabs-ntp/pull/139) ([hunner](https://github.com/hunner))
- Add metadata and supported platforms [#138](https://github.com/puppetlabs/puppetlabs-ntp/pull/138) ([hunner](https://github.com/hunner))
- Release 3.0.3 [#137](https://github.com/puppetlabs/puppetlabs-ntp/pull/137) ([hunner](https://github.com/hunner))
- Adds "Release Notes/Known Bugs" to Changelog, updates file format to markdown, standardizes the format of previous entries [#136](https://github.com/puppetlabs/puppetlabs-ntp/pull/136) ([lrnrthr](https://github.com/lrnrthr))
- Windows osfamily is lowercase [#134](https://github.com/puppetlabs/puppetlabs-ntp/pull/134) ([hunner](https://github.com/hunner))
- Add unsupported framework. [#133](https://github.com/puppetlabs/puppetlabs-ntp/pull/133) ([apenney](https://github.com/apenney))
- Add conditionals for AIX package/service names [#131](https://github.com/puppetlabs/puppetlabs-ntp/pull/131) ([hunner](https://github.com/hunner))
- Rework the requestkey's test to pass on SLES. [#130](https://github.com/puppetlabs/puppetlabs-ntp/pull/130) ([apenney](https://github.com/apenney))
- Remove unnecessary apostrophes in template [#129](https://github.com/puppetlabs/puppetlabs-ntp/pull/129) ([kristofferhagen](https://github.com/kristofferhagen))
- Add support for `disable_monitor` as a new parameter. [#128](https://github.com/puppetlabs/puppetlabs-ntp/pull/128) ([apenney](https://github.com/apenney))
- Add PE support. [#127](https://github.com/puppetlabs/puppetlabs-ntp/pull/127) ([apenney](https://github.com/apenney))
- Workaround for stdlib 3.2 in PE3.x. [#126](https://github.com/puppetlabs/puppetlabs-ntp/pull/126) ([apenney](https://github.com/apenney))
- Support running tests against Puppet Enterprise [#125](https://github.com/puppetlabs/puppetlabs-ntp/pull/125) ([justinstoller](https://github.com/justinstoller))
- Release 3.0.2 [#124](https://github.com/puppetlabs/puppetlabs-ntp/pull/124) ([apenney](https://github.com/apenney))

## [3.0.2](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.0.2) - 2014-02-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.0.1...3.0.2)

### Other

- Allow custom gemsource [#123](https://github.com/puppetlabs/puppetlabs-ntp/pull/123) ([hunner](https://github.com/hunner))
- Updates README to reflect what the module is currently doing [#120](https://github.com/puppetlabs/puppetlabs-ntp/pull/120) ([lrnrthr](https://github.com/lrnrthr))
- Prepare a 3.0.1 release. [#118](https://github.com/puppetlabs/puppetlabs-ntp/pull/118) ([apenney](https://github.com/apenney))

## [3.0.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.0.1) - 2013-12-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.0.0...3.0.1)

### Other

- Prepare a 3.0.1 release. [#118](https://github.com/puppetlabs/puppetlabs-ntp/pull/118) ([apenney](https://github.com/apenney))
- Release 3.0.0 [#116](https://github.com/puppetlabs/puppetlabs-ntp/pull/116) ([blkperl](https://github.com/blkperl))

## [3.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.0.0) - 2013-12-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/3.0.0-rc1...3.0.0)

### Other

- Release 3.0.0 [#116](https://github.com/puppetlabs/puppetlabs-ntp/pull/116) ([blkperl](https://github.com/blkperl))
- Convert the rspec-system tests over to beaker. [#114](https://github.com/puppetlabs/puppetlabs-ntp/pull/114) ([apenney](https://github.com/apenney))
- fix interpolation of #{system} in test output [#111](https://github.com/puppetlabs/puppetlabs-ntp/pull/111) ([3flex](https://github.com/3flex))
- Prepare 3.0.0-rc1 release. [#109](https://github.com/puppetlabs/puppetlabs-ntp/pull/109) ([apenney](https://github.com/apenney))

## [3.0.0-rc1](https://github.com/puppetlabs/puppetlabs-ntp/tree/3.0.0-rc1) - 2013-10-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/2.0.1...3.0.0-rc1)

### Other

- Fix formatting in the AIX section. [#107](https://github.com/puppetlabs/puppetlabs-ntp/pull/107) ([apenney](https://github.com/apenney))
- Prepend restrict when using `restrict`. [#106](https://github.com/puppetlabs/puppetlabs-ntp/pull/106) ([apenney](https://github.com/apenney))
- FM-103: Add metadata.json to all modules. [#105](https://github.com/puppetlabs/puppetlabs-ntp/pull/105) ([apenney](https://github.com/apenney))
- Gentoo facter 1.7 support [#104](https://github.com/puppetlabs/puppetlabs-ntp/pull/104) ([3flex](https://github.com/3flex))
- Fixing examples of the restrict parameter [#102](https://github.com/puppetlabs/puppetlabs-ntp/pull/102) ([BillWeiss](https://github.com/BillWeiss))
- cleanup include and ordering of classes [#100](https://github.com/puppetlabs/puppetlabs-ntp/pull/100) ([igalic](https://github.com/igalic))
- be more ignorant [#99](https://github.com/puppetlabs/puppetlabs-ntp/pull/99) ([igalic](https://github.com/igalic))
- Fix License and release 2.0.1. [#95](https://github.com/puppetlabs/puppetlabs-ntp/pull/95) ([apenney](https://github.com/apenney))
- added AIX parameters [#93](https://github.com/puppetlabs/puppetlabs-ntp/pull/93) ([senax](https://github.com/senax))
- Add option to force UDLC regardless of virtual status. [#85](https://github.com/puppetlabs/puppetlabs-ntp/pull/85) ([nvalentine-puppetlabs](https://github.com/nvalentine-puppetlabs))

## [2.0.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/2.0.1) - 2013-09-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/2.0.0...2.0.1)

### Other

- Release 2.0.0 [#94](https://github.com/puppetlabs/puppetlabs-ntp/pull/94) ([apenney](https://github.com/apenney))

## [2.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/2.0.0) - 2013-09-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/2.0.0-rc1...2.0.0)

### Other

- Release 2.0.0 [#94](https://github.com/puppetlabs/puppetlabs-ntp/pull/94) ([apenney](https://github.com/apenney))
- Update default keys file param variable to match init.pp's [#92](https://github.com/puppetlabs/puppetlabs-ntp/pull/92) ([jmswick](https://github.com/jmswick))
- Remove variables, switch to inherits. [#91](https://github.com/puppetlabs/puppetlabs-ntp/pull/91) ([apenney](https://github.com/apenney))
- 2.0-rc1 release. [#81](https://github.com/puppetlabs/puppetlabs-ntp/pull/81) ([apenney](https://github.com/apenney))

## [2.0.0-rc1](https://github.com/puppetlabs/puppetlabs-ntp/tree/2.0.0-rc1) - 2013-08-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/1.0.1...2.0.0-rc1)

### Other

- Add specs for restrict. [#88](https://github.com/puppetlabs/puppetlabs-ntp/pull/88) ([apenney](https://github.com/apenney))
- Convert restrict to an array of restrictions. [#87](https://github.com/puppetlabs/puppetlabs-ntp/pull/87) ([apenney](https://github.com/apenney))
- Merge all the templates together, add a few new features to help with the merge. [#80](https://github.com/puppetlabs/puppetlabs-ntp/pull/80) ([apenney](https://github.com/apenney))
- correct anchor pattern bug number [#79](https://github.com/puppetlabs/puppetlabs-ntp/pull/79) ([3flex](https://github.com/3flex))
- Prepare a quick 1.0.1 release to fix a quoting issue. [#75](https://github.com/puppetlabs/puppetlabs-ntp/pull/75) ([apenney](https://github.com/apenney))

## [1.0.1](https://github.com/puppetlabs/puppetlabs-ntp/tree/1.0.1) - 2013-07-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/1.0.0...1.0.1)

### Other

- Prepare a quick 1.0.1 release to fix a quoting issue. [#75](https://github.com/puppetlabs/puppetlabs-ntp/pull/75) ([apenney](https://github.com/apenney))
- Correct deprecation notice to mention 'package_ensure' [#73](https://github.com/puppetlabs/puppetlabs-ntp/pull/73) ([gws](https://github.com/gws))
- fix panic parameter in virtual machines [#72](https://github.com/puppetlabs/puppetlabs-ntp/pull/72) ([mmoll](https://github.com/mmoll))

## [1.0.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/1.0.0) - 2013-07-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/push...1.0.0)

### Other

- Prepare the 1.0.0 release. [#71](https://github.com/puppetlabs/puppetlabs-ntp/pull/71) ([apenney](https://github.com/apenney))

## [push](https://github.com/puppetlabs/puppetlabs-ntp/tree/push) - 2013-07-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/1.0.0-rc1...push)

### Other

- Prepare the 1.0.0 release. [#71](https://github.com/puppetlabs/puppetlabs-ntp/pull/71) ([apenney](https://github.com/apenney))
- Clean up README to use puppet highlight. [#70](https://github.com/puppetlabs/puppetlabs-ntp/pull/70) ([nanliu](https://github.com/nanliu))
- Archlinux now also has an osfamily fact [#69](https://github.com/puppetlabs/puppetlabs-ntp/pull/69) ([simonsd](https://github.com/simonsd))
- Formatting fixes for the rc [#68](https://github.com/puppetlabs/puppetlabs-ntp/pull/68) ([apenney](https://github.com/apenney))

## [1.0.0-rc1](https://github.com/puppetlabs/puppetlabs-ntp/tree/1.0.0-rc1) - 2013-07-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/0.3.0...1.0.0-rc1)

### Other

- Fix version. [#67](https://github.com/puppetlabs/puppetlabs-ntp/pull/67) ([apenney](https://github.com/apenney))
- WIP: Refactoring of NTP module [#66](https://github.com/puppetlabs/puppetlabs-ntp/pull/66) ([apenney](https://github.com/apenney))
- Fix NTP templates to use @ [#62](https://github.com/puppetlabs/puppetlabs-ntp/pull/62) ([c00w](https://github.com/c00w))
- Add test for virtual machines and local clocks [#54](https://github.com/puppetlabs/puppetlabs-ntp/pull/54) ([ryanycoleman](https://github.com/ryanycoleman))
- Release version 0.3.0 [#53](https://github.com/puppetlabs/puppetlabs-ntp/pull/53) ([ryanycoleman](https://github.com/ryanycoleman))
- Omit configuration for a local clock as time source if running on a VM. [#49](https://github.com/puppetlabs/puppetlabs-ntp/pull/49) ([alexjfisher](https://github.com/alexjfisher))

## [0.3.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/0.3.0) - 2013-04-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/0.2.0...0.3.0)

### Other

- Update Travis.YML [#52](https://github.com/puppetlabs/puppetlabs-ntp/pull/52) ([ryanycoleman](https://github.com/ryanycoleman))
- Restrict the versions and add 3.1 [#48](https://github.com/puppetlabs/puppetlabs-ntp/pull/48) ([richardc](https://github.com/richardc))
- ntp: fixes #19418 - allow template override [#47](https://github.com/puppetlabs/puppetlabs-ntp/pull/47) ([frimik](https://github.com/frimik))
- Update Documentation and Purge Extras [#44](https://github.com/puppetlabs/puppetlabs-ntp/pull/44) ([ryanycoleman](https://github.com/ryanycoleman))
- Update travis and gemfile to puppetlabs standard [#42](https://github.com/puppetlabs/puppetlabs-ntp/pull/42) ([blkperl](https://github.com/blkperl))
- fix copy/paste error in spec file [#39](https://github.com/puppetlabs/puppetlabs-ntp/pull/39) ([mmoll](https://github.com/mmoll))
- Add CONTRIBUTING.md [#38](https://github.com/puppetlabs/puppetlabs-ntp/pull/38) ([ryanycoleman](https://github.com/ryanycoleman))
- Update package-format for support of FreeBSD 9.x [#37](https://github.com/puppetlabs/puppetlabs-ntp/pull/37) ([ryanycoleman](https://github.com/ryanycoleman))
- Increment Modulefile for 0.2.0 release [#35](https://github.com/puppetlabs/puppetlabs-ntp/pull/35) ([ryanycoleman](https://github.com/ryanycoleman))
- Add restrict parameter [#34](https://github.com/puppetlabs/puppetlabs-ntp/pull/34) ([hunner](https://github.com/hunner))
- Make service ntp started on boot -> service 'ntp' { enable=>$enable...  [#33](https://github.com/puppetlabs/puppetlabs-ntp/pull/33) ([codingtony](https://github.com/codingtony))
- switch to the 'osfamily' fact [#29](https://github.com/puppetlabs/puppetlabs-ntp/pull/29) ([mmoll](https://github.com/mmoll))
- have the module fail on unsupported os [#28](https://github.com/puppetlabs/puppetlabs-ntp/pull/28) ([stephenrjohnson](https://github.com/stephenrjohnson))

## [0.2.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/0.2.0) - 2012-12-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/0.1.0...0.2.0)

### Other

- fairly trivial fix to make puppet-lint stop complaining, and a doc update [#31](https://github.com/puppetlabs/puppetlabs-ntp/pull/31) ([BillWeiss](https://github.com/BillWeiss))
- Fix is_virtual check in ntp.conf templates [#27](https://github.com/puppetlabs/puppetlabs-ntp/pull/27) ([mdsummers](https://github.com/mdsummers))
- Update Modulefile for 0.1.0 release [#26](https://github.com/puppetlabs/puppetlabs-ntp/pull/26) ([ryanycoleman](https://github.com/ryanycoleman))
- Added support for Amazon Linux [#25](https://github.com/puppetlabs/puppetlabs-ntp/pull/25) ([actionjack](https://github.com/actionjack))
- (#14497) Add tinker_panic option for ntpd [#19](https://github.com/puppetlabs/puppetlabs-ntp/pull/19) ([hakamadare](https://github.com/hakamadare))

## [0.1.0](https://github.com/puppetlabs/puppetlabs-ntp/tree/0.1.0) - 2012-10-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v0.0.4...0.1.0)

### Other

- added fedora support [#21](https://github.com/puppetlabs/puppetlabs-ntp/pull/21) ([ohadlevy](https://github.com/ohadlevy))
- Use spechelper gem [#20](https://github.com/puppetlabs/puppetlabs-ntp/pull/20) ([branan](https://github.com/branan))
- (#14492) Update formatting of the NTP module [#18](https://github.com/puppetlabs/puppetlabs-ntp/pull/18) ([whopper](https://github.com/whopper))
- (#11156) Fix module path fixtures so rspec works in most rubies [#17](https://github.com/puppetlabs/puppetlabs-ntp/pull/17) ([kbarber](https://github.com/kbarber))
- (#14457) Add FreeBSD support for the NTP class [#15](https://github.com/puppetlabs/puppetlabs-ntp/pull/15) ([whopper](https://github.com/whopper))
- change $operatingsystem to $::operatingsystem [#12](https://github.com/puppetlabs/puppetlabs-ntp/pull/12) ([walterheck](https://github.com/walterheck))
- (#11155) Fix templates so they are ruby-1.9.2 compatible [#10](https://github.com/puppetlabs/puppetlabs-ntp/pull/10) ([kbarber](https://github.com/kbarber))
- (#11152) Create temporary puppetconf area with empty manifests/site.pp [#9](https://github.com/puppetlabs/puppetlabs-ntp/pull/9) ([kbarber](https://github.com/kbarber))
-   Update CHANGELOG for 0.0.4 release [#7](https://github.com/puppetlabs/puppetlabs-ntp/pull/7) ([bodepd](https://github.com/bodepd))
- (#10846) add spec tests for ntp class [#6](https://github.com/puppetlabs/puppetlabs-ntp/pull/6) ([bodepd](https://github.com/bodepd))

## [v0.0.4](https://github.com/puppetlabs/puppetlabs-ntp/tree/v0.0.4) - 2011-11-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v0.0.3...v0.0.4)

### Other

- (#10707) Update documentation for amazon linux support [#5](https://github.com/puppetlabs/puppetlabs-ntp/pull/5) ([bodepd](https://github.com/bodepd))
- (#10707) Add os linux to el list [#4](https://github.com/puppetlabs/puppetlabs-ntp/pull/4) ([bodepd](https://github.com/bodepd))

## [v0.0.3](https://github.com/puppetlabs/puppetlabs-ntp/tree/v0.0.3) - 2011-06-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/v0.0.2...v0.0.3)

## [v0.0.2](https://github.com/puppetlabs/puppetlabs-ntp/tree/v0.0.2) - 2011-06-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-ntp/compare/384ffd957153f65eb4f47b3142d98853c31b4124...v0.0.2)
