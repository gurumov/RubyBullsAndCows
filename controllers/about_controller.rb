module BullsAndCows
  class AboutController < Base
    NAMESPACE = '/about'.freeze

    helpers UserHelpers

    get '/' do
      erb :'about/about'
    end
  end
end
