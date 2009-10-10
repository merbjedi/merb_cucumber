begin
  require 'cucumber/rake/task'

  # Use vendored cucumber binary if possible. If it's not vendored,
  # Cucumber::Rake::Task will automatically use installed gem's cucumber binary
  vendored_cucumber_binary = Merb.root / 'bin' / 'cucumber' if File.exist?(Merb.root / 'bin' / 'cucumber')
  
  namespace :cucumber do
    Cucumber::Rake::Task.new(:ok, 'Run features that should pass') do |t|
      t.binary = vendored_cucumber_binary if vendored_cucumber_binary
      t.fork = true # You may get faster startup if you set this to false
      t.cucumber_opts = "--color --tags ~@wip --strict --format #{ENV['CUCUMBER_FORMAT'] || 'pretty'}"
    end

    Cucumber::Rake::Task.new(:wip, 'Run features that are being worked on') do |t|
      t.binary = vendored_cucumber_binary if vendored_cucumber_binary
      t.fork = true # You may get faster startup if you set this to false
      t.cucumber_opts = "--color --tags @wip:2 --wip --format #{ENV['CUCUMBER_FORMAT'] || 'pretty'}"
    end

    desc 'Run all features'
    task :all => [:ok, :wip]
  end
  desc 'Alias for cucumber:ok'
  task :cucumber => 'cucumber:ok'

  task :default => :cucumber

  task :features => :cucumber do
    STDERR.puts "*** The 'features' task is deprecated. See rake -T cucumber ***"
  end
  
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end