# chruby

default_run_options[:shell] = '/bin/bash'

set :ruby_version, "2.0.0-p247"

set :chruby_config, "/usr/local/share/chruby/chruby.sh"
set :set_ruby_cmd, "source #{chruby_config} && chruby #{ruby_version}"
set(:bundle_cmd) {
  "#{set_ruby_cmd} && exec bundle"
}

# Bundler

require "bundler/capistrano"

set :bundle_flags, "--deployment"

# Git

set :scm,         :git
set :repository,  "git@github.com:oklahoma-atheists/oklahomaatheists.com.git"

ssh_options[:forward_agent] = true

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
  task :start, roles: :app, except: {no_release: true} do
    run "cd #{current_path}; " +
        "bin/unicorn -c #{unicorn_conf} -D -E #{rack_env}"
  end

  task :stop, roles: :app, except: {no_release: true} do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end

  task :graceful_stop, roles: :app, except: {no_release: true} do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end

  task :reload, roles: :app, except: {no_release: true} do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end

  task :restart, roles: :app, except: {no_release: true} do
    stop
    start
  end
end
