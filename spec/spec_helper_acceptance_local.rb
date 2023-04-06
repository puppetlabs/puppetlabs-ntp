# frozen_string_literal: true

include PuppetLitmus

UNSUPPORTED_PLATFORMS = ['windows', 'darwin'].freeze

def inventory_hash
  @inventory_hash ||= inventory_hash_from_inventory_file
end

def target_roles(roles)
  inventory_hash['groups'].map { |group|
    group['targets'].filter_map do |node|
      { name: node['uri'], role: node['vars']['role'] } if roles.include? node['vars']['role']
    end
  }.flatten
end

RSpec.configure do |config|
  if config.filter.rules.key? :integration
    ENV['TARGET_HOST'] = target_roles('ntpserver')[0][:name]
  else
    config.filter_run_excluding :integration
  end
end

def change_target_host(role)
  @orig_target_host = ENV.fetch('TARGET_HOST', nil)
  ENV['TARGET_HOST'] = target_roles(role)[0][:name]
end

def reset_target_host
  ENV['TARGET_HOST'] = @orig_target_host
end
