module BullsAndCows
  class AuthController < Base
    NAMESPACE = '/auth'.freeze

    helpers UserHelpers

    get '/login' do
      erb :'auth/login'
    end

    post '/login' do
      username = params[:login_username]
      password = params[:login_password]

      if username.empty? || password.empty?
        redirect NAMESPACE + '/login', error: 'Please enter both username and password!'
      end

      user = User.find(username: username)

      if user.nil?
        redirect NAMESPACE + '/login', error: 'Incorrect username or password!'
      end

      password = BCrypt::Engine.hash_secret(password, user.salt)
      if password != user.password
        redirect NAMESPACE + '/login', error: 'Incorrect username or password!'
      end

      session[:uid] = user.id
      user_title = user.first_name.nil? ? username : user.first_name
      redirect '/', success: "Welcome, #{user_title}! Go play!"
    end

    get '/logout' do
      session[:uid] = nil
      redirect '/', success: 'You\'ve logged out successfully! Have a nice day!'
    end

    get '/signup', user: :logged do
      erb :'auth/signup'
    end

    post '/signup' do
      username         = params[:username]
      password         = params[:password]
      confirmed_password = params[:confirmed_password]
      email            = params[:email]
      first_name       = params[:first_name]
      last_name        = params[:last_name]

      unless password == confirmed_password
        flash[:error] = 'The two passwords do not match. Please try again!'
        redirect NAMESPACE + '/signup'
      end

      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(password, password_salt)

      if User.find(username: username).nil? 
        user = User.create(username: username,
                           password: password_hash,
                           salt: password_salt,
                           email: email,
                           first_name: first_name,
                           last_name: last_name,
                           )

        ranking = Ranking.create()
        user.ranking = ranking

        flash[:success] = 'You have registered succesfully!'
        redirect NAMESPACE + '/login'
      else
        flash[:error] = 'The username is taken! Please select another'
        redirect NAMESPACE + '/signup'
      end
    end
  end
end
