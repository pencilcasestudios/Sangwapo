# Ref: http://gist.github.com/293302
server DEPLOYMENT_CONFIG["server_name_production"], :web, :app, :db, primary: true
set :deployment_path, DEPLOYMENT_CONFIG["deployment_path_production"]
set :deploy_to, "/var/Apps/#{application}/#{deployment_path}"

# Don't forget to make this repo on the server
set :repository_server_name, DEPLOYMENT_CONFIG["repository_server_name"]
set :repository, "#{user}@#{repository_server_name}:/var/Repositories/Git/#{application}.git"
# Don't forget to make this branch in the repository
set :branch, DEPLOYMENT_CONFIG["repository_deployment_branch"]
