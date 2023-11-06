=begin
Given the below usage of the Person class, code the class definition.
=end

# long style
class Person
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

# short-hand
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end



bob = Person.new('bob')
puts bob.name                  # => 'bob'
bob.name = 'Robert'
puts bob.name                  # => 'Robert'
