module Webistrano
  module Template
    module PHP

      CONFIG = Webistrano::Template::BasePHP::CONFIG.dup.merge({
        :clear_cache_dirs => [],
        :deploy_to => '/path/to/deployment_base',
        :environment => "dev, prod, test",
        :filters => ["jpegoptim","csstidy","yuijs","yuicss"],
        :git_enable_submodules => false,
        :local_cache => "/var/deploys/\#{webistrano_project}/\#{webistrano_stage}",
        :repository_cache => "cached-copy",
        :restart_apache => true,
        :rsync_options => "-avlz --delete",
        :shared_children => "%w(cached-copy sessions logs)",
        :shared_dirs => [],
      }).freeze

      DESC = <<-'EOS'
        Template for use with PHP projects
      EOS

      task = ""
      recipe = [ "compress", "deploy" ]
      recipe.each {|import|
        task = task + File.open("lib/webistrano/template/php/#{import}.rb", "rb").read
      }

      TASKS = Webistrano::Template::Base::TASKS + task

    end
  end
end