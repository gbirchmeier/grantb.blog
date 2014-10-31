namespace :grant do
  desc "do-nothing demo task"
  task :foo do
    puts "args: #{ARGV}"
    puts "ENV: #{Rails.env}"
    puts "pwd: #{Dir.pwd}"
  end
end

