# Sets up the Merb environment for Cucumber (thanks to krzys and roman)
require "rubygems"

require "merb-core"
require 'spec/expectations'
require "merb_cucumber/world/<%= session_type %>"
<% if orm == :datamapper -%>
require "merb_cucumber/helpers/datamapper"
<% elsif orm == :activerecord -%>
require "merb_cucumber/helpers/activerecord"
<% end -%>

# Recursively Load all steps defined within features/**/*_steps.rb
Dir["#{Merb.root}" / "features" / "**" / "*_steps.rb"].each { |f| require f }

# Uncomment if you want transactional fixtures
# Merb::Test::World::Base.use_transactional_fixtures

# Quick fix for post features running Rspec error, see 
# http://gist.github.com/37930
def Spec.run? ; true; end

Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

<% if orm == :datamapper -%>
DataMapper.auto_migrate!
<% end -%>