module MariadbBackup
  def self.save(destination_filepath)
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

    dest_dir = File.dirname(destination_filepath)
    FileUtils.mkdir_p dest_dir
    puts "  Destination: #{destination_filepath}"

    cmd = "mysqldump #{mysql_database}"
    cmd << " -u #{mysql_user}"
    cmd << " -p'#{mysql_password}'" if mysql_password.present?
    cmd << " > #{destination_filepath}"

    puts "Dumping..."
    result = system(cmd)
    raise("error, process exited with status #{$?.exitstatus}") unless result

    f = File.open(destination_filepath)
    puts "Success!  File #{destination_filepath} written (#{f.size} bytes)."
  end
end
