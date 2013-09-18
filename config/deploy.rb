# dotenv

require "dotenv/capistrano"

# chruby

default_run_options[:shell] = "/bin/bash"

set :ruby_version, "2.0.0-p247"

set :chruby_config, "/usr/local/share/chruby/chruby.sh"
set :set_ruby_cmd,  "source #{chruby_config} && chruby #{ruby_version}"
set :bundle_cmd,    "#{set_ruby_cmd} && exec bin/bundle"

# Bundler

require "bundler/capistrano"

set :bundle_flags, "--deployment"

# Git

set :scm,         :git
set :repository,  "git@github.com:oklahoma-atheists/oklahomaatheists.com.git"

# Config

set :application, "beta.oklahomaatheists.com"
set :domain,      application

# Environment

set :user,     "board"
set :use_sudo, false

role :web, domain
role :app, domain
role :db,  domain, primary: true

# Application

set :rack_env, :production

set :deploy_to,    "/var/srv/#{application}"
set :unicorn_conf, "#{current_path}/config/unicorn.rb"
set :unicorn_pid,  "#{shared_path}/pids/unicorn.pid"

# Tasks

namespace :deploy do
  desc "Start Unicorn"
  task :start, roles: :app, except: {no_release: true} do
    run "cd #{current_path}; " +
        "#{bundle_cmd} exec unicorn -c #{unicorn_conf} -D -E #{rack_env}"
  end

  desc "Halt Unicorn"
  task :stop, roles: :app, except: {no_release: true} do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end

  desc "Finish requests and stop Unicorn"
  task :graceful_stop, roles: :app, except: {no_release: true} do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end

  desc "Reload the Unicorn application"
  task :reload, roles: :app, except: {no_release: true} do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end

  desc "Halt and restart Unicorn"
  task :restart, roles: :app, except: {no_release: true} do
    stop
    start
  end

  namespace :web do
    desc "Start nginx"
    task :start, roles: :app, except: {no_release: true} do
      sudo "service nginx start"
    end

    desc "Stop nginx"
    task :stop, roles: :app, except: {no_release: true} do
      sudo "service nginx stop"
    end

    desc "Restart nginx"
    task :restart, roles: :app, except: {no_release: true} do
      sudo "service nginx restart"
    end
  end

  namespace :db do
    desc "Start PostgreSQL"
    task :start, roles: :app, except: {no_release: true} do
      sudo "service postgresql start"
    end

    desc "Stop PostgreSQL"
    task :stop, roles: :app, except: {no_release: true} do
      sudo "service postgresql stop"
    end

    desc "Restart PostgreSQL"
    task :restart, roles: :app, except: {no_release: true} do
      sudo "service postgresql restart"
    end
  end
end
