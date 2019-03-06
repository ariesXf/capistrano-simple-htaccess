namespace :load do
  task :defaults do
    set :redirect_OK, false
    set :HTACCESS, <<HTACCESS
<IfModule mod_rewrite.c>
  Options +FollowSymLinks

  RewriteEngine On
  RewriteCond %{REQUEST_URI} !/current/
  RewriteRule ^(.*)$ current/$1 [L]
</IfModule>

HTACCESS
  end
end

namespace :deploy do
  namespace :simple_htaccess do

    task :create_htaccess do
      on roles :web do
        upload! StringIO.new(fetch :HTACCESS), "#{deploy_to}/.htaccess" unless fetch(:redirect_OK)
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

    desc "Ensures basic .htaccess redirects are properly setup for Capistrano deployment"
    task ensure: [:ensure_htaccess, :create_htaccess]
  end
end

after "deploy:updated", "deploy:simple_htaccess:ensure"
