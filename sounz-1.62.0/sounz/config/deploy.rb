# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.
require 'lib/tasks/local_subversion_rsync.rb'

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "sounz"
set :repository, "svn+ssh://locke/var/svn/sounz/trunk/sounz"


set :scm, Capistrano::SCM::LocalSubversionRsync
set :repository_is_not_reachable_from_remote, true

set :local_rsync_cache, "/home/gordon/sounz_builder/cache/rsync"
set :remote_rsync_cache, "/home/gordon/sounz_build/cache/rsync"
set :use_rsync, false
set :rsync_username, "gordon"

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :app, defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.

role :app,  "lucille.catalyst.net.nz"
set :deploy_to, "/home/gordon/sounz_build/deploy"
set :use_sudo, false
set :checkout, "export"

# =============================================================================
# OPTIONAL VARIABLES
# =============================================================================
# set :deploy_to, "/path/to/app" # defaults to "/u/apps/#{application}"
# set :user, "flippy"            # defaults to the currently logged in user
# set :scm, :darcs               # defaults to :subversion
# set :svn, "/path/to/svn"       # defaults to searching the PATH
# set :darcs, "/path/to/darcs"   # defaults to searching the PATH
# set :cvs, "/path/to/cvs"       # defaults to searching the PATH
# set :gateway, "gate.host.com"  # default to no gateway

set :user, "gordon"


# =============================================================================
# SSH OPTIONS
# =============================================================================
# ssh_options[:keys] = %w(/path/to/my/key /path/to/another/key)
# ssh_options[:port] = 25

# =============================================================================
# TASKS
# =============================================================================
# Define tasks that run on all (or only some) of the machines. You can specify
# a role (or set of roles) that each task should be executed on. You can also
# narrow the set of servers to a subset of a role by specifying options, which
# must match the options given for the servers to select (like :primary => true)

desc <<DESC
An imaginary backup task. (Execute the 'show_tasks' task to display all
available tasks.)
DESC
task :backup, :roles => :app, :only => { :primary => true } do
  # the on_rollback handler is only executed if this task is executed within
  # a transaction (see below), AND it or a subsequent task fails.
  on_rollback { delete "/tmp/dump.sql" }
  
  run "mysqldump -u rails -p PASSWORD > /tmp/dump.sql" do |ch, stream, out|
    ch.send_data "thepassword\n" if out =~ /^Enter password:/
  end
end

#      
# TASKS
# 
desc "Tasks to execute after code update"
task :after_update_code, :roles => [:app] do
  # fix permissions
  run "chmod +x #{release_path}/script/process/reaper"
  run "chmod +x #{release_path}/script/process/spawner"
  run "chmod 755 #{release_path}/public/dispatch.*"
  
  #This copies the production ready database cfg file
  run "cp /home/gordon/sounz_build/config/database.yml #{release_path}/config/database.yml"
  run "cp /home/gordon/sounz_build/config/solr.yml #{release_path}/config/solr.yml"
end

#desc "Restarting after deployment"
#task :after_deploy, :roles => [:app, :app, :web] do
 # run "echo 'FIX RESTART'"
 # run "touch /home/tripodtravel/rails.tripodtravel.co.nz/photo/public/dispatch.fcgi"
#end

#desc "Restarting after rollback"
#task :after_rollback, :roles => [:app, :app, :web] do
#run "echo 'FIX ROLLBACK'"
  #run "touch  /home/tripodtravel/rails.tripodtravel.co.nz/photo/public/dispatch.fcgi"
#end