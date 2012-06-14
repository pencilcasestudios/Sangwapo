# Deployment reference documentation:
# https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning
# http://beginrescueend.com/integration/capistrano/
# http://thoughtsincomputation.com/posts/deploying-in-harmony-capistrano-rvm-bundler-and-git
# http://stackoverflow.com/questions/6472785/bundler-error-on-deployment
# https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
# Ref: http://gist.github.com/293302



# Basic steps to setup
# ON THE SERVER

# Create the MySQL database

# Create the repository:
# $ mkdir /var/Repositories/Git/#{application}.git
# $ cd /var/Repositories/Git/#{application}.git
# $ git init --bare

# Create the remotes to the production environment in the development repository
# $ git remote add production #{user}@#{server_name}:/var/Repositories/Git/#{application}.git

# Push to the repository on the server
# $ git push production master

# Create the RVM gemset
# $ rvm gemset create <<whatever-gemset-you-require>>

# Install bundler and rake in the RVM gemset
# $ rvm use <<whatever-gemset-you-required>>
# $ gem install bundler rake




# ON THE DEVELOPMENT MACHINE
# STAGING DEPLOYMENT
# $ git checkout master
# $ git merge work
# $ git push production
# $ cap deploy:setup        # Update configuration files and create the database after this
# $ cap deploy:check
# $ cap deploy:update       # May require verifying the host key.
# $ cap deploy:migrate
# $ cap db:seed
# $ cap deploy:start

# PRODUCTION DEPLOYMENT
# $ git checkout master
# $ git merge work
# $ git push production
# $ cap production deploy:setup        # Update configuration files and create the database after this
# $ cap production deploy:check
# $ cap production deploy:update       # May require verifying the host key.
# $ cap production deploy:migrate
# $ cap production db:seed
# $ cap production deploy:start
# $ git tag "`date +published_%Y-%m-%d_%H%M%S`"




# https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
require "capistrano/ext/multistage"

# https://github.com/collectiveidea/delayed_job/wiki/Rails-3-and-Capistrano
require "delayed/recipes"  



# Multi-stage deployment
# https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
#set :deploy_env, "production"
set :stages, [DEPLOYMENT_CONFIG["stage_name_staging"], DEPLOYMENT_CONFIG["stage_name_production"]]
set :default_stage, DEPLOYMENT_CONFIG["stage_name_staging"]

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

# Load RVM's capistrano plugin.
require "rvm/capistrano"                                            




depend :remote, :gem, "bundler", ">=1.0.21"
depend :remote, :gem, "rake", ">=0.9.2.2"





#set :server_name, DEPLOYMENT_CONFIG["server_name"] - now gets configured in config/deploy/{stage_name}.rb
#role :app, application
#role :web, application
#role :db,  application, :primary => true




# set :deploy_to, "/var/Apps/#{application}" - now gets configured in config/deploy/{stage_name}.rb
set :deploy_via, :remote_cache
set :copy_cache, true
set :use_sudo, false




set :scm, :git
# Don't forget to make this repo on the server
set :repository_server_name, DEPLOYMENT_CONFIG["repository_server_name"]
set :repository, "#{user}@#{repository_server_name}:/var/Repositories/Git/#{application}.git"
# Don't forget to make this branch in the repository
set :branch, DEPLOYMENT_CONFIG["repository_deployment_branch"]




namespace :deploy do
  task :start do ; end

  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,"tmp","restart.txt")}"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/examples/config.yml"), "#{shared_path}/config/config.yml"
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
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
before "deploy:setup", "rvm:install_rvm"
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
