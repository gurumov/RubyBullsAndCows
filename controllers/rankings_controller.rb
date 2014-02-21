module BullsAndCows
  class RankingsController < Base
    NAMESPACE = '/rankings'.freeze

    helpers UserHelpers

    get '/', user: :logged do
      erb :'rankings/top'
    end

  end
end
