module MariadbBackup
  def self.save(dest_dir)
    puts "Making backup for:"
    puts "  Rails env: #{Rails.env}"

    full_config_path = Rails.root.join("config/database.yml")
    puts "  Config: #{full_config_path}"

    info = YAML::load(IO.read(full_config_path))
    raise "No db config for '#{Rails.env}'" unless info[Rails.env]

    mysql_database = info[Rails.env]["database"]
    mysql_user = info[Rails.env]["username"]
    mysql_password = info[Rails.env]["password"]
    puts "  DB: #{mysql_database}"

    FileUtils.mkdir_p dest_dir
    dest_file = "#{dest_dir}/#{mysql_database}-#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.sql"
    puts "  Destination: #{dest_file}"

    cmd = "mysqldump #{mysql_database} -u #{mysql_user} -P '#{mysql_password}' > #{dest_file}"

    puts "Dumping..."
    result = system(cmd)
    raise("error, process exited with status #{$?.exitstatus}") unless result

    f = File.open(dest_file)
    puts "Success!  File #{dest_file} written (#{f.size} bytes)."
  end
end
