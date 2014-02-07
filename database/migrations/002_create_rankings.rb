Sequel.migration do
  change do
    create_table(:rankings) do
      primary_key :id, index: true
	  foreign_key :user_id, :users, null: false, index: true
	  Integer :total_games, default: 0
      Integer :games_won, default: 0
	  Integer :games_lost, default: 0
      Integer :rank, default: 0, index: true
    end
  end
end

