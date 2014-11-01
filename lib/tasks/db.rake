require Rails.root.join("lib/mariadb_backup")

namespace :db do
  desc "back up the db; must pass in 'dest=dir' argument"
  task :backup do
    raise "missing dest argument" unless ENV['dest']
    MariadbBackup.save(ENV['dest'])
  end
end
