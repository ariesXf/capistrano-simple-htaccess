# frozen_string_literal: true

namespace :load do
  task :defaults do
    set :redirect_OK, false
    set :document_root, '/var/www/html'
    set :HTACCESS, <<~HTACCESS
      <IfModule mod_rewrite.c>
        Options +FollowSymLinks

        RewriteEngine On
        RewriteBase "%<base>s"
        RewriteRule ^current(.*) %<base>s$1 [NC,R,END]
        RewriteRule ^((?!current/).*)$ current/$1 [NC,END]
      </IfModule>

    HTACCESS
  end
end

namespace :deploy do
  namespace :simple_htaccess do
    task :create_htaccess do
      on roles :web do
        document_root = fetch :document_root
        base_dir = deploy_to.delete_prefix(document_root)
        filled_template = format(fetch(:HTACCESS), base: base_dir)
        upload! StringIO.new(filled_template), "#{deploy_to}/.htaccess" unless fetch(:redirect_OK)
      end
    end

    task :ensure_htaccess do
      on roles :web do
        path = "#{deploy_to}/.htaccess"
        if test("[ -f #{path} ]")
          existing_text = capture :cat, path
          set :redirect_OK, (existing_text.strip == fetch(:HTACCESS).strip)
        else
          execute :touch, path
        end
      end
    end

    desc 'Ensures basic .htaccess redirects are properly setup for Capistrano deployment'
    task ensure: %i[ensure_htaccess create_htaccess]
  end
end

after 'deploy:updated', 'deploy:simple_htaccess:ensure'
