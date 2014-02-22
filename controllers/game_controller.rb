module BullsAndCows
  class GameController < Base
    NAMESPACE = '/game'.freeze

    helpers UserHelpers
    helpers GameHelpers

    set :bot, nil

    get '/', user: :logged do
      erb :'game/choices'
    end

    get '/findOpponent', user: :logged do 

      user = current_user.find_best_match
      if user.nil?
        flash[:info] = "We couldn't find you an opponent! Bummer..."
        redirect NAMESPACE + '/'
      end

      #become available
      #find opponent
      #create connection
      #not available

      erb :'game/lobby'
    end

    post '/findOpponent',  user: :logged do 
      number = params[:number]

      unless valid? number
        flash[:error] = 'You have entered an invalid number!'
        redirect NAMESPACE + '/findOpponent'
      end

      sessiom[:number] = number
      redirect NAMESPACE + '/player'
    end

    get '/init', user: :logged do
      erb :'game/init'
    end

    post '/init', user: :logged do

      number = params[:number]

      unless valid? number
        flash[:error] = 'You have entered an invalid number!'
        redirect NAMESPACE + '/init'
      end
      
      bot = BCLogic.new number
      settings.bot = bot

      session[:number] = number
      redirect NAMESPACE + '/bot'
    end

    get '/bot', user: :logged do
      @usernumber = session[:number]
      bot = settings.bot
      @user_guesses = bot.player_guesses
      @opponent_guesses = bot.opponent_guesses
      erb :'game/botgame'
    end

    post '/bot', user: :logged do
      guess = params[:guess]
      if valid? guess
        bot = settings.bot
        if bot.player_guess guess
          ranking = Ranking.where(user_id: current_user.id).first
          ranking.victory
          redirect NAMESPACE + '/victory'
        elsif bot.opponent_guess
          ranking = Ranking.where(user_id: current_user.id).first
          ranking.defeat
          redirect NAMESPACE + '/defeat'
        else
          settings.bot = bot
          redirect NAMESPACE + '/bot'
        end
      else
        flash[:error] = 'You have entered an invalid number!'
        redirect NAMESPACE + '/bot'
      end
    end

    get '/player', user: :logged do
      erb :'game/playergame'
    end

    post '/player', user: :logged do
    end

    get '/defeat', user: :logged do 
      erb :'game/defeat'
    end

    get '/victory', user: :logged do 
      erb :'game/victory'
    end
  end
end
