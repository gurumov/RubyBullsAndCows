module BullsAndCows
  class Base < Sinatra::Base
    use Rack::Flash

    register Sinatra::Partial
    register Sinatra::ConfigFile

    helpers Sinatra::RedirectWithFlash

    config_file 'config/config.yml'

    enable :sessions
    set :environment, settings.environment

    set :views,         File.expand_path(settings.views_path)
    set :public_folder, File.expand_path(settings.public_path)
    set :partial_template_engine, :erb

    Bundler.require settings.environment

    configure :development do
      DB = Sequel.sqlite settings.development[:sqlite_path]
    end

    register do
      def user (type)
        condition do
          unless send "#{type}?"
            flash[:info] = 'You need to be logged in to access this page.'
            redirect "auth/login"
          end
        end
      end

     
    end
  end
end
