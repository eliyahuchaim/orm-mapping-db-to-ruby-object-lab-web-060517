require 'pry'

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    student = Student.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    query = "SELECT * FROM students"
    return_value = DB[:conn].execute(query)
    return_value.map do |student|
      self.new_from_db(student)
    end
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = "SELECT * FROM students WHERE name = #{'name'}"
    return_value = DB[:conn].execute(sql).first
    self.new_from_db(return_value)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.count_all_students_in_grade_9
    grade9 = []
    sql = "SELECT * FROM students WHERE grade = 9"
    return_value = DB[:conn].execute(sql)
    return_value.map do |student|
      grade9 << student
    end
    grade9
  end

  def self.students_below_12th_grade
    grade11 = []
    sql = "select * from students where grade < 12"
    return_value = DB[:conn].execute(sql)
    return_value.map do |student|
      grade11 << grade11
    end
    grade11
  end

  def self.first_x_students_in_grade_10(x)
    arr = []
    sql = "SELECT * FROM students WHERE grade = 10 LIMIT #{x}"
    return_value = DB[:conn].execute(sql)
    return_value.map do |student|
      arr << student
    end
    arr
  end

  def self.first_student_in_grade_10
    sql = "select * from students where grade = 10 limit 1"
    return_value = DB[:conn].execute(sql).first
    self.new_from_db(return_value)
  end

  def self.all_students_in_grade_x(x)
    arr = []
    sql = "select * from students where grade = #{x}"
    return_value = DB[:conn].execute(sql)
    return_value.map do |student|
      arr << student
    end
    arr
  end


end
