=begin
What is the method lookup path and how is it important?
=end

# The method lookup path defines how a method call decides what valid method to
# execute. It starts by looking in the current class, then it searches included
# modules, starting with the last one included. It then jumps to the superclass
# and repeats this process. If a valid method isn't found yet, then it continues
# to Object, Kernel, and BasicObject. This can be clearly demonstrated by
# overwriting the to_s method as a class or instance method - as shown in
# previous exercises

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

p Bulldog.ancestors
# This demonstrates the method lookup path for class of Bulldog
# ALL classes sub-class from Object

