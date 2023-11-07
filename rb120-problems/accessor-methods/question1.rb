=begin
Add the appropriate accessor methods to the following code.
=end

# Equivalent without short-hand
class Person
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
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

# Because of the default nature of setter methods, we don't need to worry about
# a constructor method here. However, we do need to set a value before
# getting it
