=begin
Continuing with our Person class definition, what does the below code print out?
=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    create_full_name(name)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(name)
    create_full_name(name)
  end

  private

  def create_full_name(name)
    full_name = name.split
    @first_name = full_name.first
    @last_name = full_name.size == 1 ? '' : full_name.last
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# This prints out that the person's name is an actual string representation of
# the object, which includes the class name with a formated object id



=begin
Let's add a to_s method to the class. Now, what does the below print out?
=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    create_full_name(name)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(name)
    create_full_name(name)
  end

  def to_s
    name
  end

  private

  def create_full_name(name)
    full_name = name.split
    @first_name = full_name.first
    @last_name = full_name.size == 1 ? '' : full_name.last
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# This prints out the return value of the name getter method. There is now a
# to_s method closer in the lookup chain that bob is able to call. In this
# case, Object#to_s is overiden and the bob object calls the name getter 
