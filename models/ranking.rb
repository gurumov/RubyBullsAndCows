class Ranking < Sequel::Model
	many_to_one :user

  def victory
    self.games_won += 1
    self.total_games += 1
    self.rank += 1
    self.save
  end

  def defeat
    self.games_lost += 1
    self.total_games += 1
    self.rank -= 1
    self.save
  end
end