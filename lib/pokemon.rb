class Pokemon

    attr_accessor :name, :type, :db, :id, :hp

    def initialize(id: nil, name:, type:, db:, hp: nil)
        @id = id
        @name = name
        @type = type
        @db = db
        @hp = hp
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES (?, ?);
        SQL
        db.execute(sql, name, type) 
        # db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?;
        SQL
        db.execute(sql, id).map{|row| self.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3])}.first
    end

    def alter_hp(hp, db)
        sql = <<-SQL
        UPDATE pokemon SET hp = ? WHERE id = ?;
        SQL
        db.execute(sql, hp, self.id)
        # db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
    end
end
