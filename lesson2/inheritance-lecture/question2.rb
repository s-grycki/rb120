=begin
Create a new class called Cat, which can do everything a dog can, except swim 
or fetch. Assume the methods do the exact same thing. Hint: don't just copy 
and paste all methods in Dog into Cat; try to come up with some class hierarchy.
=end

# Organized with module inhetitance

=begin
module SharedBehaviors
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog
  include SharedBehaviors

  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat
  include SharedBehaviors

  def speak
    'meow!'
  end
end

class Bulldog < Dog
  include SharedBehaviors

  def swim
    "Can't swim!"
  end
end

kitty = Cat.new
puts kitty.speak
puts kitty.run
puts kitty.jump

doggy = Dog.new
puts doggy.speak
puts doggy.run
puts doggy.jump
puts doggy.swim
puts doggy.fetch

bully = Bulldog.new
puts doggy.speak
puts doggy.run
puts doggy.jump
puts doggy.swim
puts doggy.fetch
=end



# Organized with class inheritance

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

kitty = Cat.new
puts kitty.speak
puts kitty.run
puts kitty.jump

doggy = Dog.new
puts doggy.speak
puts doggy.run
puts doggy.jump
puts doggy.swim
puts doggy.fetch

bully = Bulldog.new
puts doggy.speak
puts doggy.run
puts doggy.jump
puts doggy.swim
puts doggy.fetch
