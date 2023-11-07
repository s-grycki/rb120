=begin
Modify the following code so that Hello! I'm a cat! is printed when
Cat.generic_greeting is invoked.
=end

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

=begin
Further Exploration:
What happens if you run kitty.class.generic_greeting? Can you explain this result?
=end

kitty = Cat.new
kitty.class.generic_greeting
# generic_greeting is a class method getting called on a class. If we were to
# check the return value of kitty.class, this returns Cat because class is a
# Kernel method which returns the class of a called object. The output is the
# same
