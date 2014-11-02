namespace :backup do
  desc "backup the web server's database; is downloaded to 'dest=<path>' parameter"
  task :db do
    remote_rails_env = fetch(:rails_env)
    remote_dest_path = "/var/tmp/grantb.blog/"
    filename_base = "grantbblog_#{remote_rails_env}-#{DateTime.now.strftime("%Y%m%d_%H%M%S")}"

    local_dest = ENV['dest'] || "."
    local_dest += "/" unless local_dest.last=="/"

    on roles(:db) do
      within release_path do
        with rails_env: remote_rails_env do
          execute :rake, "db:backup dest=#{remote_dest_path}#{filename_base}.sql"
          execute "cd #{remote_dest_path} && gzip #{filename_base}.sql"
          download! "#{remote_dest_path}#{filename_base}.gz", local_dest
        end
      end
    end
  end
end
