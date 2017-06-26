# encoding: UTF-8
# frozen_string_literal: true

lock '3.8.2'

set :application,          'searchspace'
set :repo_url,             'git@github.com:yivo/searchspace.git'
set :user,                 'deploy'
set :deploy_via,           :remote_cache
set :format_options,       truncate: false, command_output: true

# capistrano-rbenv
set :rbenv_root, '/usr/local/rbenv'

# capistrano-bundler
set :bundle_roles,         :app
set :bundle_servers,       -> { release_roles(fetch(:bundle_roles)) }
set :bundle_bins,          %w[ gem rake rails ]
set :bundle_gemfile,       -> { release_path.join('Gemfile') }
set :bundle_path,          -> { shared_path.join('bundle') }
set :bundle_without,       'development test'
set :bundle_flags,         '--deployment'
set :bundle_env_variables, {}
set :bundle_clean_options, ''
set :bundle_jobs,          4

# capistrano-rails
set :rails_env,                  nil
set :migration_role,             :app
set :migration_servers,          []
set :conditionally_migrate,      false
set :assets_roles,               :app
set :assets_prefix,              'assets'
set :rails_assets_groups,        nil
set :normalize_asset_timestamps, []
set :keep_assets,                2
set :linked_dirs,                fetch(:linked_dirs, [])  + %w[ log tmp/pids tmp/cache tmp/sockets ]
set :linked_dirs,                fetch(:linked_dirs, [])  + %w[ public/assets ]
set :linked_files,               fetch(:linked_files, []) + %w[ .rbenv-vars ]

task 'bower' do
  on release_roles :app do
    within release_path do
      with rails_env: fetch(:rails_env), ci: true do
        rake 'bower:install'
      end
    end
  end
end

before 'deploy:assets:precompile', 'bower'
