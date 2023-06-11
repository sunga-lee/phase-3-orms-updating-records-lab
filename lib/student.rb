require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade, :id
 
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, *args)
    @name = name
    @grade = grade
    args[0]==nil? @id=nil :@id = args[0]
  end
  
    def self.create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name Text,
          grade INTEGER
        )
        SQL
        DB[:conn].execute(sql)
      end
    end
    def self.drop_table
      sql = <<-SQL
        DROP TABLE IF EXISTS students
        SQL
      DB[:conn].execute(sql)
    end 

    def.save
      if self.id
        self.update
      else
        sql = <<-SQL
          INSERT INTO students (name, grade)
          VALUES (?,?)
          sql
        DB[:conn].execute(sql, self.name, self.grade)
        self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
        self
      end
    end
    def self.create(name, grade)
      student = self.new(name, grade)
      student.save
      student
    end
    def self.new_from_db(row)
      self.new(row[1],row[2],row[0])
    end
    def self.all
      sql = <<-SQL
        SELECT *
        FROM students
      SQL
    
    
      DB[:conn].execute(sql).map do |row|
          self.new_from_db(row)
      end
    end
    def self.find_by_name(name)
      sql = <<-SQL
        SELECT *
        FROM students
        WHERE name = ?
        LIMIT 1
      SQL
    
      DB[:conn].execute(sql, name).map do |row|
        self.new_from_db(row)
      end.first
    end
    def update
      sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
      DB[:conn].execute(sql, self.name, self.grade, self.id)
    end


  end  


end
