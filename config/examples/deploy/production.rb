# Ref: http://gist.github.com/293302
server DEPLOYMENT_CONFIG["server_name_production"], :web, :app, :db, :primary => true
set :deployment_path, DEPLOYMENT_CONFIG["deployment_path_production"]
set :deploy_to, "/var/Apps/#{application}/#{deployment_path}"
