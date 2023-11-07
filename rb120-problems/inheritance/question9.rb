=begin
Using the following code, determine the lookup path used when invoking
bird1.color. Only list the classes or modules that were checked by Ruby
when searching for the #color method.
=end

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color
p bird1.class.ancestors # => [Bird, Flyable, Animal, Object, Kernel, BasicObject]
# The color method isn't found in bird, so it goes to flyable. It's not in
# flyable, so it goes on to animal. A color getter method is found in Animal,
# so this is the method used
