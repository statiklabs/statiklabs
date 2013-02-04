set :application, "statiklabs"
set :repository,  "ssh://ysarazin@git.statiklabs.com:10056/~/git/statiklabs.git" 
set :scm, :git
set :branch, "master"
set :user, "ysarazin"
set :group, "apache"
set :runner, "ysarazin"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :keep_releases, 5
set :ssh_options, {:forward_agent => true, :port => 10056}
role :app, "97.107.139.12"
role :web, "97.107.139.12"
role :db,  "97.107.139.12", :primary => true

default_run_options[:pty] = true

namespace :deploy do
  task :restart do
    # no need to restart the app
  end
end

deploy.task :finalize_update, :roles => :app do
  cleanup
  run "#{try_sudo} chgrp -R apache #{deploy_to}"
  run "#{try_sudo} chmod +x #{deploy_to}"
end