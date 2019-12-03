require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3', 
    database: 'db/development.db'
    )
ActiveRecord::Base.Logger.new(STDOUT)

require_all 'lib'
