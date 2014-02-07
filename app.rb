require 'bundler/setup'

Bundler.require :default

require './database/models/user'
require './database/models/ranking'

sqlite_path = './database/bcDB.db'.freeze
DB = Sequel.sqlite sqlite_path

module BullsAndCows

  get '/' do
    erb 'Hello'
  end

end




