module BullsAndCows
  class GameController < Base
    NAMESPACE = '/game'.freeze

    helpers UserHelpers
    helpers GameHelpers

    get '/', user: :logged do
      erb :'game/choices'
    end

    get '/findOpponent', user: :logged do 

      user = current_user.find_best_match
      if user.nil?
        flash[:info] = "We couldn't find you an opponent!"
        redirect NAMESPACE + '/findOpponent'
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

       # if "userNumber" not in request.session:
       #  if isValid(userGuess):
       #      request.session["gameInProgress"] = True
       #      request.session["userNumber"] = userGuess
       #      unusedDigits = [x for x in range(10)]
       #      request.session["unusedDigits"] = unusedDigits
       #      bot = AI(userGuess)
       #      request.session["bot"] = bot
       #      userGuesses = []
       #      request.session["userGuesses"] = userGuesses
       #      botGuesses = []
       #      request.session["botGuesses"] = botGuesses
       #      context = {"userNumber": userGuess, "unusedDigits": unusedDigits}
       #      return render(request, 'BullsAndCows/Play.html', context)
       #  else:
       #      context = {"invalid_number": "Invalid number!"}
       #      return render(request, 'BullsAndCows/NewGame.html', context)

      number = params[:number]

      unless valid? number
        flash[:error] = 'You have entered an invalid number!'
        redirect NAMESPACE + '/init'
      end
      
      bot = BCLogic.new number
      set :bot, bot

      session[:number] = number
      redirect NAMESPACE + '/bot'
    end

    get '/bot', user: :logged do
      @usernumber = session[:number]
      @unused_digits =  (0..9).to_a.join(',')
      bot = settings.bot
      @user_guesses = bot.player_guesses
      @opponent_guesses = bot.opponent_guesses
      erb :'game/botgame'
    end

    post '/bot', user: :logged do
      guess = params[:guess]
      if valid? guess
        bot = session[:bot]
        if bot.player_guess guess
          redirect NAMESPACE + '/victory'
        elsif bot.opponent_guess
          redirect NAMESPACE + '/defeat'
        else
          session[:bot] = bot
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
