# When running the following code:

#class Person
#  attr_reader :name
#  def initialize(name)
#    @name = name
#  end
#end
#
#bob = Person.new("Steve")
#bob.name = "Bob"

# We get the following error:
# test.rb:9:in `<main>': undefined method `name=' for
#    #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get it and how do we fix it?




# The error tells us about an undefined setter method of name for the instance
# variable of name pointing the string 'Steve'. This is because the original
# code used attr_reader. This only creates a getter method. This can be easily
# fixed by using attr_accessor to implicity create both a getter and setter
# method

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
puts bob.name
bob.name = "Bob"
puts bob.name
