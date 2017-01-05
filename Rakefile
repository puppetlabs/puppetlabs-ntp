require 'puppet_blacksmith/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
require 'rspec/core/rake_task'


PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_single_quote_string_with_variables')

desc 'Generate pooler nodesets'
task :gen_nodeset do
  require 'beaker-hostgenerator'
  require 'securerandom'
  require 'fileutils'

  agent_target = ENV['TEST_TARGET']
  if ! agent_target
    STDERR.puts 'TEST_TARGET environment variable is not set'
    STDERR.puts 'setting to default value of "redhat-64default."'
    agent_target = 'redhat-64default.'
  end

  master_target = ENV['MASTER_TEST_TARGET']
  if ! master_target
    STDERR.puts 'MASTER_TEST_TARGET environment variable is not set'
    STDERR.puts 'setting to default value of "redhat7-64mdcl"'
    master_target = 'redhat7-64mdcl'
  end

  targets = "#{master_target}-#{agent_target}"
  cli = BeakerHostGenerator::CLI.new([targets])
  nodeset_dir = "tmp/nodesets"
  nodeset = "#{nodeset_dir}/#{targets}-#{SecureRandom.uuid}.yaml"
  FileUtils.mkdir_p(nodeset_dir)
  File.open(nodeset, 'w') do |fh|
    fh.print(cli.execute)
  end
  puts nodeset
end


desc 'Running acceptance test on single and multi node set ups, nodeset needs provided by the user'
RSpec::Core::RakeTask.new(:tag) do |t|
  # Test mode must always be set
  test_mode = ENV['BEAKER_TESTMODE'].to_sym
  raise 'BEAKER_TESTMODE env variable must be either agent or apply.' unless %w(agent apply).include?(test_mode.to_s)

  # Setup rspec opts
  t.rspec_opts = ['--color']

  # NODE_SETUP env variable is a comma separated list of node setups to run. e.g. singlenode, multinode
  if ENV['NODE_setup']
    node_setup = ENV['NODE_setup'].split(',')
    raise 'NODE_setup env variable must have at least 1 node setup specified. low, medium or high (comma separated).' if node_setup.count == 0
    node_setup.each do |node|
      raise "#{node} not a valid node setup." unless %w(singlenode multinode).include?(node)
      t.rspec_opts.push("--tag #{node}")
    end
  else
    puts 'NODE_setup env variable not defined. Defaulting to run all tests.'
  end

  # Implement an override for the pattern with BEAKER_PATTERN env variable.
  t.pattern = ENV['BEAKER_PATTERN'] ? ENV['BEAKER_PATTERN'] : 'spec/acceptance'
end