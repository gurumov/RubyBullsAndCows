class User < Sequel::Model
	one_to_one :ranking

 # def find_best_match
    #ranking_dataset.
   # users = DB[:users].select(:id, :rank).where(:is_active).join(:rankings, :user_id => :id).order(:rank)
   # user_rank = ranking_dataset.map(:rank)
  #   opponent = 
  #   DB.transaction do
  #     user = User.for_update.first(id: user_id)
  #     user.is_active = false
  #     user.save
  #   end
  # end

  def self.active_users?
    not User.where(:is_active).emptty?
  end
end