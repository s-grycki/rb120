=begin
Fix the following code so it works properly:

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
=end

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678

# We have to be careful in Ruby. Creating a local variable is as simple as
# just typing a valid name without any prefix. In this case, Ruby thought we
# were creating a local variable called mileage inside of the method definition
# What the code wants to do is access the mileage setter method. We can do this
# by prepending self onto mileage so Ruby knows it's calling a method on the
# calling object
