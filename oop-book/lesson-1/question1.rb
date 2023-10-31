=begin
How do we create an object in Ruby? Give an example of the creation of an object.
=end

# Objects are created from classes using a process called instantiation.
# Anything that can be said to have a value is an object. This includes:
# Numbers, strings, arrays, classes, and modules. Methods, blocks, and
# variables are examples of non-objects in Ruby, despite the common saying
# that everything in Ruby is an object

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
