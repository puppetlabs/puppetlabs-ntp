require 'puppet_blacksmith/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'

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

require 'rspec/core/rake_task'
desc 'test tiering'
RSpec::Core::RakeTask.new(:test_tier) do |t|

  # Test mode must always be set
  test_mode = ENV['BEAKER_TESTMODE'].to_sym
  raise 'BEAKER_TESTMODE env variable must be either agent or apply.' unless %w(agent apply).include?(test_mode.to_s)

  # If no hosts file is set, use beaker-hostgenerator to build one based on env variables
  # BEAKER_MASTER & BEAKER_AGENT env variables accept valid beaker-hostgenerator platforms
  # test_mode = agent
  #   PE_DIR        - required.
  #   BEAKER_MASTER - required.
  #   BEAKER_AGENT  - optional - if not set this will run master and agent on one VM.
  # test_mode = apply
  #   BEAKER_AGENT  - required.
  if(!ENV['BEAKER_setfile'] and !ENV['BEAKER_set'])
    raise 'Cannot use apply testmode without specifying an agent' if(test_mode == :apply and !ENV['BEAKER_AGENT'])
    raise 'Cannot use agent testmode without specifying a master' if(test_mode == :agent and !ENV['BEAKER_MASTER'])
    raise 'Cannot use agent testmode without specifying a pe dir' if(test_mode == :agent and !ENV['PE_DIR'])

    hostgen_string = 'beaker-hostgenerator '
    if(test_mode == :agent)
      hostgen_string += ENV['BEAKER_MASTER']
      if(ENV['BEAKER_AGENT'])
        # 1 x Master - 1 x Agent setup
        hostgen_string += 'mdcl-' + ENV['BEAKER_AGENT'] + 'default.af'
      else
        # All in one master/agent on one box
        hostgen_string += 'default.mdclaf'
      end
      hostgen_string += ' --pe_dir ' + ENV['PE_DIR']
    elsif(test_mode == :apply)
      # Agent only install
      hostgen_string += ENV['BEAKER_AGENT'] + 'default.a'
    end
    ENV['BEAKER_set'] = 'autogen_beaker_set'
  end

  # Generate the nodeset file
  sh hostgen_string + ' > spec/acceptance/nodesets/autogen_beaker_set.yml'

  # Setup rspec opts
  t.rspec_opts = ['--color']

  # TEST_TIERS env variable is a comma separated list of tiers to run. e.g. low-medium-high
  if ENV['TEST_TIERS']
    test_tiers = ENV['TEST_TIERS'].split(',')
    raise 'TEST_TIERS env variable must have at least 1 tier specified. low, medium or high (comma separated).' if test_tiers.count == 0
    test_tiers.each do |tier|
      raise "#{tier} not a valid test tier." unless %w(low medium high).include?(tier)
      t.rspec_opts.push("--tag tier_#{tier}")
    end
  else
    puts 'TEST_TIERS env variable not defined. Defaulting to run all tests.'
  end

  # Implement an override for the pattern with BEAKER_PATTERN env variable.
  t.pattern = ENV['BEAKER_PATTERN'] ? ENV['BEAKER_PATTERN'] : 'spec/acceptance'
end