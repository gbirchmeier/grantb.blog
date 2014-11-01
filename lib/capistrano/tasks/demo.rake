namespace :demo do
  desc "run a demo command"
  task :foo do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute 'pwd'
          execute :rake, 'grant:foo'
        end
      end
    end
  end
end

