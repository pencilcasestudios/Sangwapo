# Ref: http://gist.github.com/293302
server DEPLOYMENT_CONFIG["server_name_staging"], :web, :app, :db, :primary => true
set :deployment_path, DEPLOYMENT_CONFIG["deployment_path_staging"]
set :deploy_to, "/var/Apps/#{application}/#{deployment_path}"
