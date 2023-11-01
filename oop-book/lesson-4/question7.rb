=begin
Create a class 'Student' with attributes name and grade. Do NOT make the grade 
getter public, so joe.grade will raise an error. Create a better_grade_than? 
method, that you can call like so...

Create student class w/ attributes name + grade
The getter should be protected 
Create method better_grade_than?

=end

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  attr_reader :grade
end

joe = Student.new('Joe', 95)
steve = Student.new('Steve', 90)
puts "Well done!" if joe.better_grade_than?(steve)
# joe.grade # Would throw an error
