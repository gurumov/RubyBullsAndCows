module BullsAndCows
  class GameController < Base
    NAMESPACE = '/game'.freeze

    helpers UserHelpers

    get '/', user: :logged do
      erb :'game/choices'
    end

    get '/bot', user: :logged do
      erb :'game/newgame'
    end

    get '/player', user: :logged do
    end

    get '/defeat', user: :logged do 
      erb :'game/defeat'
    end

    get '/victory', user: :logged do 
      erb :'game/victory'
    end
  end
end
