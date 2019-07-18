require_relative('../db/sql_runner.rb')


class Student

  attr_reader :first_name, :last_name, :house, :age, :id

  def initialize(options)
    @id = options['id'].to_i
    @first_name = options['first_name']
    @last_name = options['last_name']
    @house = options['house']
    @age = options['age'].to_i
  end

  def save()
    sql = "INSERT INTO students
    (
      first_name,
      last_name,
      house,
      age
      )
      VALUES
      (
        $1, $2, $3, $4
        )
      RETURNING *"
      values = [@first_name, @last_name, @house, @age]
      student_data = SqlRunner.run(sql, values)
      @id = student_data.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM students"
    students = SqlRunner.run(sql)
    return students.map { |student| Student.new(student)}
  end

  def self.find(id)
    sql = "SELECT * FROM students"
    values = [id]
    student = SqlRunner.run(sql, values)
    return Student.new(student.first)
  end

  def pretty_name()
    return "#{@first_name} #{@last_name}"
  end










end
