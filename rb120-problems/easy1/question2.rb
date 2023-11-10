=begin
Take a look at the following code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

What output does this code print? Fix this class so that there are no surprises
waiting in store for the unsuspecting developer.
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# The first call returns the name getter method call, which just returns the
# name instance variable associated with the fluffy object. Then puts implictly
# calls to to_s on this return. That's why it's lowercase.

# On the second call, we're calling the fluffy object with puts. This calls the
# custom to_s class available to instances of Pet. This mutates the instance
# variable and impacts the value the rest of the program. Both the local and
# instance variables were pointing to the same object




class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# We can just call upcase on the getter return in a non-destructive manner.
# This makes the program less fragile




# Further Exploration:
# What happens with these test cases?

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# This code would throw an error if we removed the to_s in initialize.
# The @name instance variable is actually being initialize to a different
# object than the local variable. That's because calling to_s on an integer
# returns a new string object. The fluffy object is initialized with the
# original variable. Then the name local variable is incremented by 1. 
# Therefore, every instance will have 42. The local variable will have 43
