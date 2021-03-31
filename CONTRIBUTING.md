# Contributing to Puppet modules

So you want to contribute to a Puppet module: Great! Below are some instructions to get you started doing
that very thing while setting expectations around code quality as well as a few tips for making the
process as easy as possible. 

### Table of Contents

1. [Getting Started](#getting-started)
1. [Commit Checklist](#commit-checklist)
1. [Submission](#submission)
1. [More about commits](#more-about-commits)
1. [Testing](#testing)
    - [Running Tests](#running-tests)
    - [Writing Tests](#writing-tests)
1. [Get Help](#get-help)

## Getting Started

- Fork the module repository on GitHub and clone to your workspace

- Make your changes!

## Commit Checklist

### The Basics

- [x] my commit is a single logical unit of work

- [x] I have checked for unnecessary whitespace with "git diff --check" 

- [x] my commit does not include commented out code or unneeded files

### The Content

- [x] my commit includes tests for the bug I fixed or feature I added

- [x] my commit includes appropriate documentation changes if it is introducing a new feature or changing existing functionality

- [x] my code passes existing test suites

### The Commit Message

- [x] the first line of my commit message includes:

  - [x] an issue number (if applicable), e.g. "(MODULES-xxxx) This is the first line"
  
  - [x] a short description (50 characters is the soft limit, excluding ticket number(s))

- [x] the body of my commit message:

  - [x] is meaningful

  - [x] uses the imperative, present tense: "change", not "changed" or "changes"

  - [x] includes motivation for the change, and contrasts its implementation with the previous behavior

## Submission

### Pre-requisites

- Make sure you have a [GitHub account](https://github.com/join)

- [Create a ticket](https://tickets.puppet.com/secure/CreateIssue!default.jspa), or [watch the ticket](https://tickets.puppet.com/browse/) you are patching for.

### Push and PR

- Push your changes to your fork

- [Open a Pull Request](https://help.github.com/articles/creating-a-pull-request-from-a-fork/) against the repository in the puppetlabs organization

### Adding a label

- We encourage contributors to add a label to your PR, this will help with categorising your changes when making a release. The label can be *maintaince, bugfix, feature, backwards incompatible.*

## More about commits

  1.  Make separate commits for logically separate changes.

      Please break your commits down into logically consistent units
      which include new or changed tests relevant to the rest of the
      change.  The goal of doing this is to make the diff easier to
      read for whoever is reviewing your code.  In general, the easier
      your diff is to read, the more likely someone will be happy to
      review it and get it into the code base.

      If you are going to refactor a piece of code, please do so as a
      separate commit from your feature or bug fix changes.

      We also really appreciate changes that include tests to make
      sure the bug is not re-introduced, and that the feature is not
      accidentally broken.

      Describe the technical detail of the change(s).  If your
      description starts to get too long, that is a good sign that you
      probably need to split up your commit into more finely grained
      pieces.

      Commits which plainly describe the things which help
      reviewers check the patch and future developers understand the
      code are much more likely to be merged in with a minimum of
      bike-shedding or requested changes.  Ideally, the commit message
      would include information, and be in a form suitable for
      inclusion in the release notes for the version of Puppet that
      includes them.

      Please also check that you are not introducing any trailing
      whitespace or other "whitespace errors".  You can do this by
      running "git diff --check" on your changes before you commit.

  2.  Sending your patches

      To submit your changes via a GitHub pull request, we _highly_
      recommend that you have them on a topic branch, instead of
      directly on "main".
      It makes things much easier to keep track of, especially if
      you decide to work on another thing before your first change
      is merged in.

      GitHub has some pretty good
      [general documentation](http://help.github.com/) on using
      their site.  They also have documentation on
      [creating pull requests](https://help.github.com/articles/creating-a-pull-request-from-a-fork/).

      In general, after pushing your topic branch up to your
      repository on GitHub, you can switch to the branch in the
      GitHub UI and click "Pull Request" towards the top of the page
      in order to open a pull request.

  3.  Update the related JIRA issue.

      If there is a JIRA issue associated with the change you
      submitted, then you should update the ticket to include the
      location of your branch, along with any other commentary you
      may wish to make.

# Testing

## Getting Started

Our Puppet modules provide [`Gemfile`](./Gemfile)s, which can tell a Ruby package manager such as [bundler](http://bundler.io/) what Ruby packages,
or Gems, are required to build, develop, and test this software.

Please make sure you have [bundler installed](http://bundler.io/#getting-started) on your system, and then use it to 
install all dependencies needed for this project in the project root by running

```shell
% bundle install --path .bundle/gems
Fetching gem metadata from https://rubygems.org/........
Fetching gem metadata from https://rubygems.org/..
Using rake (10.1.0)
Using builder (3.2.2)
-- 8><-- many more --><8 --
Using rspec-system-puppet (2.2.0)
Using serverspec (0.6.3)
Using rspec-system-serverspec (1.0.0)
Using bundler (1.3.5)
Your bundle is complete!
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

NOTE: some systems may require you to run this command with sudo.

If you already have those gems installed, make sure they are up-to-date:

```shell
% bundle update
```

## Checking your PR automated test results

When you create a PR, our automated test suite will automatically pick up your changes and run tests against them. 
This will highlight and regressions that you change may have introduced.

### How do I know the status of the automated tests?

Within your PR if you click on the commits you will one of 3 tiny icons beside the SHA of your commit.

- A green tick (Tests have passed)
- A red cross (Tests have failed)
- A yellow dot (Tests are still running)

A PR will not be merged with failing tests, if you click on the small red cross icon it will give you additional information
on what has actually failed. Once this is addressed you can commit your fix and continue working. If your fix is difficult and
you need to do additional debugging check out the section in this document called **Running tests on your local machine** as this 
will allow you to run interactive debugging sessions using pry.

## Running Tests on your local machine

With all dependencies in place and up-to-date, run the tests:

### Unit Tests

```shell
% bundle exec rake spec
```

This executes all the [rspec tests](http://rspec-puppet.com/) in the directories defined [here](https://github.com/puppetlabs/puppetlabs_spec_helper/blob/699d9fbca1d2489bff1736bb254bb7b7edb32c74/lib/puppetlabs_spec_helper/rake_tasks.rb#L17) and so on.
rspec tests may have the same kind of dependencies as the module they are testing. Although the module defines these dependencies in its [metadata.json](./metadata.json),
rspec tests define them in [.fixtures.yml](./fixtures.yml).

### Acceptance Tests

All Puppet Supported modules come with acceptance tests, which use [puppet litmus][puppet-litmus].
Litmus supports multiple provisioners, that exist in the [provision module][provision-module].
When using litmus it is built up of different rake tasks, this allows you to remain in control when testing.
When running your tests locally there will be 5 main steps you will be interested in.

1) Installing your bundle
2) Provisioning your machine(s)
3) Installing your agent
4) Installing the module
5) Running your tests

In order to complete the above you run the following commands:
*(Note this specific set up is running tests on centos7 and puppet agent version 6, the commands will need altered depending on your specific needs)*

```shell
% bundle install
% bundle exec rake 'litmus:provision[provision::docker,litmusimage/centos:7]'
% bundle exec rake 'litmus:install_agent[puppet6]'
% bundle exec rake litmus:install_module
% bundle exec rake parallel_spec
```

If you would like to run tests on a collection of OS you can use the command:
```shell
% bundle exec rake 'litmus:provision_list[release_checks]'
```
*release_checks* refers to the machines listed under the key release checks in the module **provision.yaml** file located in the root of the module directory.

## Writing Tests

### Unit Tests

When writing unit tests for Puppet, [rspec-puppet][] is your best friend. It provides tons of helper methods for testing your manifests against a 
catalog (e.g. contain_file, contain_package, with_params, etc). It would be ridiculous to try and top rspec-puppet's [documentation][rspec-puppet_docs] 
but here's a tiny sample:

Sample manifest:

```puppet
file { "a test file":
  ensure => present,
  path   => "/etc/sample",
}
```

Sample test:

```ruby
it 'does a thing' do
  expect(subject).to contain_file("a test file").with({:path => "/etc/sample"})
end
```

### Acceptance Tests

A common pattern for acceptance tests is to create a test manifest, apply it
twice to check for idempotency or errors, then run expectations.

```ruby
it 'does an end-to-end thing' do
  pp = <<-EOF
    file { 'a test file': 
      ensure  => present,
      path    => "/etc/sample",
      content => "test string",
    }
    
  apply_manifest(pp, :catch_failures => true)
  apply_manifest(pp, :catch_changes => true)
  
end

describe file("/etc/sample") do
  it { is_expected.to contain "test string" }
end

```
# If you have commit access to the repository

Even if you have commit access to the repository, you still need to go through the process above, and have someone else review and merge
in your changes.  The rule is that **all changes must be reviewed by a project developer that did not write the code to ensure that
all changes go through a code review process.**

The record of someone performing the merge is the record that they performed the code review. Again, this should be someone other than the author of the topic branch.

# Get Help

Check out our [blog post][reaching-out-blog] on how to reach the team if your having issues.

[rspec-puppet]: http://rspec-puppet.com/
[rspec-puppet_docs]: http://rspec-puppet.com/documentation/
[beaker-rspec]: https://github.com/puppetlabs/beaker-rspec
[puppet-litmus]: https://puppet.com/blog/litmus-new-module-acceptance-testing-tool/
[provision-module]: https://github.com/puppetlabs/provision
[reaching-out-blog]: https://puppetlabs.github.io/iac/team/2021/01/20/reaching-out.html