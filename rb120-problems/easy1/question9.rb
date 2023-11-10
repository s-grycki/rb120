=begin
Consider the following program.

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

Update this code so that when you run it, you see the following output:
My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.
=end

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :name, :age, :color

  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch



# Further Exploration:
# An alternative approach to this problem would be to modify the Pet class to
# accept a colors parameter. If we did this, we wouldn't need to supply an
# initialize method for Cat.

# Why would we be able to omit the initialize method? Would it be a good idea
# to modify Pet in this way? Why or why not? How might you deal with some of
# the problems, if any, that might arise from modifying Pet?

# Cat wouldn't need an initialize method because it would be able to use the
# constructor inheritied from Pet as it is. It may or may not be a good idea.
# This depends on the rest of the code implimentation. Do we want all pets to
# have a color attribute? If not, then this impacts the flexibility of using
# the superclass constructor. We would have to create custom constructors for
# each differing class, while keeping in mind that the superclass constructor
# may ask for more arguments than we can supply
