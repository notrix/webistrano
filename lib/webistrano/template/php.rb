module Webistrano
  module Template
    module PHP

      CONFIG = Webistrano::Template::BasePHP::CONFIG.dup.merge({
        :clear_cache_dirs => [],
        :environment => "dev, prod, test",
        :filters => ["jpegoptim","csstidy","yuijs","yuicss"],
        :git_enable_submodules => false,
        :restart_apache => true,
        :shared_dirs => [],
        :deploy_to => '/path/to/deployment_base',
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