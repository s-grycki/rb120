=begin
Create a class called MyCar. When you initialize a new instance or object of
the class, allow the user to define some instance variables that tell us the 
year, color, and model of the car. Create an instance variable that is set to 
0 during instantiation of the object to track the current speed of the car as 
well. Create instance methods that allow the car to speed up, brake, 
and shut the car off.
=end



class MyCar
  attr_accessor :speed

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(increase)
    self.speed = speed + increase
    puts "You push the gas and accelerate #{increase} mph."
  end

  def brake(decrease)
    self.speed = speed - decrease
    puts "You push the brake and decelerate #{decrease} mph."
  end

  def current_speed
    puts "You are now going #{speed} mph."
  end

  def shut_off
    self.speed = 0
    puts "Let's park this bad boy!"
  end
end

car = MyCar.new(2024, 'blue', 'Grand Cherokee')
car.speed_up(30)
car.brake(10)
car.current_speed
car.shut_off

# attr_accessor automatically creates getter/setter methods with the symbol
# argument(s) as 2 different methods

# initialize serves as a constructor with the passed values to assign instance
# variables

# The method logic is this: Set the speed state of the object to the return of
# the current get method call for speed plus the passed value. This demonstrates
# some of Ruby's syntatical sugar - where we're achieveing this with logical
# assignment instead of a method call with an argument
