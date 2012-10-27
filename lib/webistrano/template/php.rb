module Webistrano
  module Template
    module PHP

      CONFIG = Webistrano::Template::Base::CONFIG.dup.merge({
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