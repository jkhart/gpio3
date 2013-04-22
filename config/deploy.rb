require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "gpio2"

set :repository,  "git@github.com:jkhart/gpio2.git"
set :scm, :git

set :deploy_to, "/home/pi/applications/#{application}"
set :deploy_via, :remote_cache
set :user, "pi"
set :sudo, 'rvmsudo'
set :use_sudo, true
set :normalize_asset_timestamps, false

set :rvm_ruby_string, "1.9.3-p392"
set :rvm_bin_path, "/home/#{user}/.rvm/bin/"
set :rvm_type, :user

role :web, "192.168.1.110"
role :app, "192.168.1.110"
role :db,  "192.168.1.110", :primary => true

namespace :deploy do
  task :start do
    run "export rvmsudo_secure_path=1; cd #{current_path} && bundle exec rvmsudo rails s -e production -d -P #{shared_path}/pids/server.pid"
  end
  task :stop do
    begin
      run "export rvmsudo_secure_path=1; rvmsudo kill -9 `cat #{shared_path}/pids/server.pid`"
    rescue Exception => exception
      puts exception.message
    end
    #run "ps aux | grep 'rails s' | awk '{ print $2 }'"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end
after "deploy:restart", "deploy:cleanup"
