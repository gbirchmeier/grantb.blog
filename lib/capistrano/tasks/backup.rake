namespace :backup do
  desc "backup the web server's database"
  task :db do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:backup dest=/var/tmp/grantb.blog/'
# todo: zip and download
        end
      end
    end
  end
end
