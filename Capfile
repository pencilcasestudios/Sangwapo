load "deploy" if respond_to?(:namespace) # cap2 differentiator

DEPLOYMENT_CONFIG = YAML.load_file("./config/config.yml")["production"]

# Ref: https://github.com/capistrano/capistrano/issues/81#issuecomment-1994285
require "bundler/capistrano"

# Uncomment if you are using Rails' asset pipeline
load "deploy/assets"

Dir["vendor/gems/*/recipes/*.rb","vendor/plugins/*/recipes/*.rb"].each { |plugin| load(plugin) }

load "config/deploy" # remove this line to skip loading any of the default tasks
