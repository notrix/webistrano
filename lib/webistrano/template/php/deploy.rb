set :rsync_options, '-avlz --delete'
set :shared_children,   %w(cached-copy sessions logs)
set :repository_cache, 'cached-copy'
set :local_cache, "/var/deploys/#{stagename}"

before "deploy:finalize_update" , "compress:start"
after "deploy:create_symlink" , "deploy:deploy_php" , "deploy:cleanup"

namespace :deploy do

  task :restart, :roles => :app, :except => { :no_release => true } do
   # do nothing
  end

  task :start, :roles => :app, :except => { :no_release => true } do
   # do nothing
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
   # do nothing
  end

  task :create_symlink, :roles => :app, :except => { :no_release => true } do
   # do nothing
  end

  task :finalize_update do
    sudo "rm -fr #{release_path}/.git"
    run "chmod -R g+w #{latest_release}"
  end

  task :clear_cache_dirs_action do
    clear_cache_dirs.each{|dir|
      sudo "rm -fr --preserve-root #{shared_path}/#{dir}"
    }
  end

  task :apache_graceful do
    sudo "/etc/init.d/apache2 graceful"
  end

  task :symlink_shared_dirs do
    shared_dirs.each{|dir|

      dir_path  = File.dirname(dir)
      dir_last = File.basename(dir)

      if dir_path == '.'
        run <<-CMD
          mkdir -p #{shared_path}/#{dir} &&
          ln -sfn #{shared_path}/#{dir_last} #{latest_release}/#{dir}
        CMD

        sudo "chmod -R g+w #{shared_path}/#{dir_last}"
      else
        run <<-CMD
          mkdir -p #{shared_path}/#{dir} &&
          mkdir -p #{latest_release}/#{dir_path} &&
          ln -sfn #{shared_path}/#{dir} #{latest_release}/#{dir_path}/#{dir_last}
        CMD

        sudo "chmod -R g+w #{shared_path}/#{dir}"
      end
    }
  end

  task :symlink_config_files do
    run <<-CMD
      rm -rf #{latest_release}/config &&
      mv  #{latest_release}/configs/#{environment} #{latest_release}/config &&
      rm -r #{latest_release}/configs &&
      rm -f #{current_path} &&
      ln -s #{latest_release} #{current_path}
    CMD
  end

  task :deploy_php do

    if shared_dirs.kind_of?(Array)
      logger.info "Create symlink for shared dir, and make them writable"
      symlink_shared_dirs
    end

    if clear_cache_dirs.kind_of?(Array)
      logger.info "Clearing cache dirs"
      clear_cache_dirs_action
    end

   symlink_config_files

    if( restart_apache )
      logger.info "Restart apache and clear apc cache"
      apache_graceful
    end

  end

end


