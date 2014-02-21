Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id, index: true
      foreign_key :ranking_id, :rankings, index: true
      String :username, size: 32, unique: true, null: false
      String :password, null: false
      String :salt, null: false
      String :first_name
      String :last_name
      String :email   
      TrueClass :is_active, default: false
    end
  end
end