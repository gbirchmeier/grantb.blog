def usage
  "backup <backup_destination_dir>"
end

unless ARGV.count > 0
  puts usage
  raise 'Invalid args'
end

dest_dir = ARGV.shift


if Rails.env.production?           
  env = "production"
elsif Rails.env.staging?
  env = "staging"
else
  env = "development"
end                    

puts "+++#{Rails.root}"
full_config_path = Rails.root.join("config/database.yml")
puts "+++#{full_config_path}"
 

info = YAML::load(IO.read(Rails.root.join("config/database.yml")))
mysql_database = info[env]["database"]
mysql_user = info[env]["username"]
mysql_password = info[env]["password"]  
        
        
FileUtils.mkdir_p dest_dir
dest_file = "#{dest_dir}/#{mysql_database}-#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.sql"
 
cmd = "mysqldump #{mysql_database} -u #{mysql_user} -P '#{mysql_password}' > #{dest_file}"   

result = system(cmd)
raise("error, process exited with status #{$?.exitstatus}") unless result
 

