namespace :grant do
  desc "do-nothing demo task"
  task :foo do
    puts "args: #{ARGV}"
    puts "Rails.env: #{Rails.env}"
    puts "pwd: #{Dir.pwd}"
  end
end

