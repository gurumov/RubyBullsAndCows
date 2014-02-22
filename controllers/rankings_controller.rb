module BullsAndCows
  class RankingsController < Base
    NAMESPACE = '/rankings'.freeze

    helpers UserHelpers

    get '/', user: :logged do

      @rankings = Ranking.reverse_order(:rank).limit(10)
      @user_ranking = Ranking.find(user_id: current_user.id)

      erb :'rankings/top'
    end

  end
end
