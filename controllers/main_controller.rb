module BullsAndCows
  class MainController < Base
    NAMESPACE = '/'.freeze

    helpers UserHelpers
    
    get '/' do
      erb :'home/index'
    end
  end
end
