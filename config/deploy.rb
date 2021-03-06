set :application, "gurupu"
set :repository,  "git@github.com:kcheart/gurupu.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :ssh_options, { :forward_agent => true }
set :user, "railsapp"
set :group, "railsapp"

role :web, "gurupu"                          # Your HTTP server, Apache/etc
role :app, "gurupu"                          # This may be the same as your `Web` server
role :db,  "gurupu", :primary => true # This is where Rails migrations will run
role :db,  "gurupu"

set :runner, "railsapp"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :use_sudo, false

set :deploy_to, "/home/#{user}/#{application}"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end