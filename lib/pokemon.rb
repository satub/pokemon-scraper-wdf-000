require_relative '../bin/environment.rb'  #for testing the code at the end of this file


class Pokemon

  attr_accessor :id, :name, :type, :hp, :db
#  database_connection = SQLite3::Database.new('db/my_database.db')

    def initialize(id, name, type, db, hp = 60)
      @id = id
      @name = name
      @type = type
      @db = db
      @hp = hp
    end

    def self.save(name, type, db)
        # database_connection = SQLite3::Database.open(db)
        db.execute("INSERT INTO pokemon
        (name, type) VALUES (?,?)", name, type)
    end

    def self.find(id, db)
      db.execute("SELECT * FROM pokemon WHERE id=?",id)
    end

    def self.alter_hp(id, hp, db)
      db.execute("UPDATE pokemon SET hp=? WHERE id=?", hp, id)
    end
end

#just having fun with this... :D
require_relative '../bin/sql_runner.rb'
db = SQLite3::Database.new('test_pokemon.db')
db.execute("DROP TABLE IF EXISTS pokemon")
sql_runner = SQLRunner.new(db)
sql_runner.execute_schema_migration_sql
pikachu = Pokemon.new(1,"Pikachu","fire",db)
Pokemon.save("Pikachu", "fire", db)
Pokemon.find(1,db)
Pokemon.alter_hp(1,20,db)
