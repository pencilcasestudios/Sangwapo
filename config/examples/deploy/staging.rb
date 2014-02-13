# Ref: http://gist.github.com/293302
server DEPLOYMENT_CONFIG["staging_server_name"], :web, :app, :db, primary: true
set :deployment_path, DEPLOYMENT_CONFIG["staging_deployment_path"]
set :deploy_to, "/var/Apps/#{application}/#{deployment_path}"

# Don't forget to make this repo on the server
set :repository_server_name, DEPLOYMENT_CONFIG["staging_server_name"]
set :repository, "#{user}@#{repository_server_name}:/var/Repositories/Git/#{application}.git"
# Don't forget to make this branch in the repository
set :branch, DEPLOYMENT_CONFIG["staging_repository_deployment_branch"]
