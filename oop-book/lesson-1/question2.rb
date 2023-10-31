=begin
What is a module? What is its purpose? How do we use them with our classes?
Create a module for the class you created in exercise 1 and include it properly
=end

# A module is a form of polymorphism which allow shared behaviors between
# classes. The difference between a module and a class is that you cannot
# create an object from a module. Modules are mixed in with a class using
# the include invocation. This is called a mix in. After mixing in the module,
# those behaviors become available to the class and its objects

# My previous example shows a module example with Speak. It defines a method
# which outputs an argument to the console and mixes this functionality into
# different classes to achieve shared behavior. Since all these classes
# are accessing the same module, we can just call the method defined in the
# module onto a new instance(object) of these classes




module Speak
  def greeting(greet)
    puts "#{greet}"
  end
end

class EnglishSpeaker
  include Speak
end

class FrenchSpeaker
  include Speak
end

class GermanSpeaker
  include Speak
end

class SpanishSpeaker
  include Speak
end

bob = EnglishSpeaker.new
bob.greeting('Hello')

jack = FrenchSpeaker.new
jack.greeting('Bonjour')

ann = GermanSpeaker.new
ann.greeting('Guten Tag')

alex = SpanishSpeaker.new
alex.greeting('Hola')
