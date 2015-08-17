role :web, %w{172.245.32.193}
role :app, %w{172.245.32.193}
role :db,  %w{172.245.32.193}

set :deploy_to, '/home/blog/rails_apps/grantb.blog/prod'
set :branch, 'deploy-prod'
set :pid_file, '/home/blog/pids/grantb.blog.prod.pid'
set :server_port, 3222

server "172.245.32.193", roles: %{web db app}, ssh_options: {
    user: "blog",
    forward_agent: true,
    auth_methods: %w(publickey)
}

