require 'erb'

module Capistrano
  module UnicornNginx
    module Helpers

      def bundle_unicorn(*args)
        SSHKit::Command.new(:bundle, :exec, :unicorn, args).to_command
      end

      def template(template_name, target)
        config_file = "#{fetch(:templates_path)}/#{template_name}"
        # if no customized file, proceed with default
        unless File.exists?(config_file)
          config_file = File.join(File.dirname(__FILE__), "../../generators/capistrano/unicorn_nginx/templates/#{template_name}")
        end
        config_stream = StringIO.new(ERB.new(File.read(config_file)).result(binding))
        upload! config_stream, target
      end

      def file_exists?(path)
        test "[ -e #{path} ]"
      end

    end
  end
end