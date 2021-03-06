# Deployment reference documentation:
# https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning
# http://beginrescueend.com/integration/capistrano/
# http://thoughtsincomputation.com/posts/deploying-in-harmony-capistrano-rvm-bundler-and-git
# http://stackoverflow.com/questions/6472785/bundler-error-on-deployment
# https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
# Ref: http://gist.github.com/293302




# https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
require "capistrano/ext/multistage"

# https://github.com/collectiveidea/delayed_job/wiki/Rails-3-and-Capistrano
require "delayed/recipes"

# https://github.com/westarete/capistrano-helpers#campfire
#require "capistrano-helpers/campfire"

# https://github.com/wayneeseguin/rvm-capistrano
require "rvm/capistrano"




# Multi-stage deployment
# https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
#set :deploy_env, "production"
set :stages, [DEPLOYMENT_CONFIG["virtual_stage_name"], DEPLOYMENT_CONFIG["staging_stage_name"], DEPLOYMENT_CONFIG["production_stage_name"]]
set :default_stage, DEPLOYMENT_CONFIG["virtual_stage_name"]

set :rails_env, "production" # Added for delayed job

# Customise these application-specific settings by updating config.yml used by Settingslogic
# DEPLOYMENT_CONFIG is initialised in Capfile
set :application, DEPLOYMENT_CONFIG["application_name"]
set :gemset_name, DEPLOYMENT_CONFIG["gemset_name"]
set :ruby_version, DEPLOYMENT_CONFIG["ruby_version"]
# set :server_name, DEPLOYMENT_CONFIG["server_name"] - Server name now gets configured in config/deploy/{stage_name}.rb
set :user, DEPLOYMENT_CONFIG["user"]
set :bundle_without, [:darwin, :development, :test]
set :rvm_ruby_gemset, "#{ruby_version}@#{gemset_name}"              # Don't forget to create gemset on the server
set :rvm_ruby_string, "#{rvm_ruby_gemset}"                          # Select the gemset




depend :remote, :gem, "bundler", "#{DEPLOYMENT_CONFIG["miniumum_version_of_bundler"]}"
depend :remote, :gem, "rake", "#{DEPLOYMENT_CONFIG["miniumum_version_of_rake"]}"




#set :server_name, DEPLOYMENT_CONFIG["server_name"] - now gets configured in config/deploy/{stage_name}.rb
#role :app, application
#role :web, application
#role :db,  application, :primary => true




# set :deploy_to, "/var/Apps/#{application}" - now gets configured in config/deploy/{stage_name}.rb
set :deploy_via, :remote_cache
set :copy_cache, true
set :use_sudo, false




set :scm, :git




namespace :deploy do
  task :start do ; end

  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,"tmp","restart.txt")}"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/examples/config/config.yml"), "#{shared_path}/config/config.yml"
    put File.read("config/examples/database/database.yml"), "#{shared_path}/config/database.yml"
    #put File.read("config/examples/twitter.yml"), "#{shared_path}/config/twitter.yml"
    puts "Now edit the config files in #{shared_path}."
  end

  desc "Symlink extra configs and folders."
  task :symlink_extras do
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    #run "ln -nfs #{shared_path}/config/twitter.yml #{release_path}/config/twitter.yml"
  end
end




# Database tasks
# Ref: https://gist.github.com/157958
namespace :db do
  desc "Populates the Production Database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=production"
  end
end




# Server tasks
# Ref: https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
namespace :deployment_server do
  desc "Display the (UNIX) server operating system name"
  task :uname do
    run "uname -a"
  end
end




# http://beginrescueend.com/integration/capistrano/
# RVM-Capistrano
before "deploy:setup", "rvm:create_gemset"
before "deploy:setup", "rvm:install_rvm" # Get the latest RVM

before "deploy", "rvm:install_rvm"


after "deploy", "deploy:cleanup" # keeps only last 5 releases
after "deploy:setup", "deploy:setup_shared"
after "deploy:finalize_update", "deploy:symlink_extras"

# https://github.com/collectiveidea/delayed_job/wiki/Rails-3-and-Capistrano
# Delayed Job
before "deploy:restart", "delayed_job:stop"
after  "deploy:restart", "delayed_job:start"

after "deploy:stop",  "delayed_job:stop"
after "deploy:start", "delayed_job:start"
