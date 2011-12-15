# Deployment reference documentation:
# https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning
# http://beginrescueend.com/integration/capistrano/
# http://thoughtsincomputation.com/posts/deploying-in-harmony-capistrano-rvm-bundler-and-git
# http://stackoverflow.com/questions/6472785/bundler-error-on-deployment




# Basic steps to setup
# ON THE SERVER

# Create the repository:
# $ mkdir /var/Repositories/Git/#{application_name}.git
# $ cd /var/Repositories/Git/#{application_name}.git
# $ git init --bare

# Create the remotes in the development repository
# $ git remote add deployment #{user}@#{server_name}:/var/Repositories/Git/#{application_name}.git

# Push to the repository on the server
# $ git push deployment master
# $ git push deployment deployment

# Create the RVM gemset
# $ rvm gemset create <<whatever-gemset-you-require>>

# Install bundler and rake in the RVM gemset
# $ rvm use <<whatever-gemset-you-required>>
# $ gem install bundler rake



# ON THE DEVELOPMENT MACHINE
# git push deployment deployment
# $ cap deploy:setup        # Update configuration files and create the database after this
# $ cap deploy:check
# $ cap deploy:update       # May require verifying the host key.
# $ cap deploy:migrate
# $ cap deploy:start



# https://github.com/collectiveidea/delayed_job/wiki/Rails-3-and-Capistrano
require "delayed/recipes"  
set :rails_env, "production" #added for delayed job  

# Customise these application-specific settings by updating config/config.yml
# DEPLOYMENT_CONFIG is initialised in Capfile
set :application_name, DEPLOYMENT_CONFIG["application_name"]
set :gemset_name, DEPLOYMENT_CONFIG["gemset_name"]
set :ruby_version, DEPLOYMENT_CONFIG["ruby_version"]
set :server_name, DEPLOYMENT_CONFIG["server_name"]
set :user, DEPLOYMENT_CONFIG["user"]

set :rvm_ruby_gemset, "#{ruby_version}@#{gemset_name}"




set :bundle_without, [:darwin, :development, :test]

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))              # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                            # Load RVM's capistrano plugin.
# Don't forget to create gemset on the server
set :rvm_ruby_string, "#{rvm_ruby_gemset}"                          # Select the gemset
set :rvm_type, :user                                                # RVM install is in the deploying user's home directory




depend :remote, :gem, "bundler", ">=1.0.21"
depend :remote, :gem, "rake", ">=0.9.2.2"





set :application, DEPLOYMENT_CONFIG["server_name"]
role :app, application
role :web, application
role :db,  application, :primary => true




set :deploy_to, "/var/Apps/#{application_name}"
set :deploy_via, :remote_cache
set :copy_cache, true
set :use_sudo, false




set :scm, :git
# Don't forget to make this repo on the server
set :repository, "#{user}@#{server_name}:/var/Repositories/Git/#{application_name}.git"
# Don't forget to make this branch in the repository
set :branch, DEPLOYMENT_CONFIG["deployment_branch"]




namespace :deploy do
  task :start do ; end

  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,"tmp","restart.txt")}"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/examples/config.yml"), "#{shared_path}/config/config.yml"
    puts "Now edit the config files in #{shared_path}."
  end

  desc "Symlink extra configs and folders."
  task :symlink_extras do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
end




after "deploy", "deploy:cleanup" # keeps only last 5 releases
after "deploy:setup", "deploy:setup_shared"
after "deploy:finalize_update", "deploy:symlink_extras"

# https://github.com/collectiveidea/delayed_job/wiki/Rails-3-and-Capistrano
# Delayed Job  
before "deploy:restart", "delayed_job:stop"
after  "deploy:restart", "delayed_job:start"

after "deploy:stop",  "delayed_job:stop"
after "deploy:start", "delayed_job:start"
