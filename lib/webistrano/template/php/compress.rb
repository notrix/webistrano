namespace :compress do

  def local_cache_path
    File.expand_path(local_cache)
  end

  def rsync_host(server)
    defined?(:user) ? "#{user}@#{server.host}" : server.host
  end

  def update_remote_cache
    finder_options = {:except => { :no_release => true }}
    find_servers(finder_options).each {|s| system(rsync_command_for(s)) }
  end

  def rsync_command_for(server)
    "rsync #{rsync_options} --rsh='ssh -p #{ssh_port(server)}' #{local_cache_path}/ #{rsync_host(server)}:#{repository_cache_path}/"
  end

  def copy_remote_cache
    run "rsync -a --delete #{repository_cache_path}/ #{release_path}/"
  end

  def ssh_port(server)
    server.port || ssh_options[:port] || 22
  end

  def rsync_host(server)
    defined?(:user) ? "#{user}@#{server.host}" : server.host
  end

  def repository_cache_path
    File.join(shared_path, repository_cache)
  end

  task :csstidy do
    logger.info "CSStidy on all *.css files"
    system("find #{local_cache_path} -name *.css -exec csstidy {} {} >> /dev/null \\;")
  end

  task :yuicss do
    logger.info "Yuicompressor on all *.css files"
    system("find  #{local_cache_path} -name '*.css' -exec /usr/bin/yui-compressor {} -o {} \\; ")
  end

  task :yuijs do
    logger.info "Yuicompressor on all *.js files"
    system("find  #{local_cache_path} -name '*.js' -exec /usr/bin/yui-compressor {} -o {} \\; ")
  end

  task :jpegoptim do
    logger.info "Jpegoptim on all *.jpeg and *.jpg files"
    system("find #{local_cache_path} -iregex '.*\\.\\(jpg\\|jpeg\\)' | xargs jpegoptim -optv -m90 >> /dev/null ")
  end

  task :optipng do
    logger.info "Optipng on all *.png files"
    system("find #{local_cache_path} -name '*.png' -exec optipng -o7 {} >> /dev/null \\;")
  end

  task :start do
    compressors = [ "csstidy", "optipng", "yuicss", "yuijs", "jpegoptim" ]
    compressors.each { |compressor|
      if filters.include?(compressor)
        func = "#{compressor}"
        eval func
      end
    }

    update_remote_cache
    copy_remote_cache
  end
end
