# config valid only for current version of Capistrano
lock '3.8.2'

# ### Para agilidade
set :user, 'deploy'
set :format, :airbrussh
set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'
set :rvm_sudo, false
# ###

set :application, 'signo'
set :repo_url, 'https://github.com/shooghr/signofalse.git'
set :branch, 'master'
set :deploy_to, '/var/www/signofalse'
set :stage, :production
set :pty, false
set :keep_releases, 5

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
append :linked_files, 'config/database.yml', 'config/secrets.yml'

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/sockets/puma.sock"
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 4
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true

# namespace :deploy do
#   desc 'Run WebSocket'
#   task :websocket do
#   end
# end