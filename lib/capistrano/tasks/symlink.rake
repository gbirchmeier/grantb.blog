namespace :custom do
  desc "create a symlink to db config already on the server"
  task :symlink_db_config do
    on roles(:web) do
      execute "ln -nfs /home/blog/config/database.yml #{release_path}/config/database.yml"
    end
  end
end
