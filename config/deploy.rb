# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'grantb.blog'
set :repo_url, 'git@github.com:gbirchmeier/grantb.blog.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  before :updated, :create_config_symlinks do
    on roles(:web,:app,:db) do
      execute "ln -nfs /home/blog/config/database.yml #{release_path}/config/database.yml"
      execute "ln -nfs /home/blog/config/initializers/secret_token.rb #{release_path}/config/secret_token.rb"
    end
  end


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      pid_file = fetch(:pid_file)

      # yes, this sucks.  Will switch to puma or something in the near future.
      within release_path do
        execute "((ls #{pid_file} && ps -p `cat #{pid_file}`) && kill -9 `cat #{pid_file}`) || true"
        execute "(ls #{pid_file} && /bin/rm #{pid_file}) || true"
        execute "cd #{fetch(:deploy_to)}/current && bundle exec rails server" +
          " -e #{fetch(:rails_env)}" +
          " -p #{fetch(:server_port)}" +
          " -d" +
          " --pid=#{pid_file} "
      end
    end
  end

  after :publishing, :restart

end
