=begin
Create a superclass called Vehicle for your MyCar class to inherit from and 
move the behavior that isn't specific to the MyCar class to the superclass. 
Create a constant in your MyCar class that stores information about the 
vehicle that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass 
that also has a constant defined that separates it from the MyCar class 
in some way.

Create superclass Vehicle
Have MyCar inherit all non-specific behavior from Vehicle
Create constant in MyCar that stores info about vehicle

Create new class of MyTruck that inherits from Vehicle
Create constant in MyTruck that stores info about vehicle

=end

class Vehicle
  attr_accessor :speed, :color
  attr_reader :year, :model

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

  def spray_paint(new_color)
    self.color = new_color
    puts "Your car is now #{new_color}"
  end

  def self.mpg(gallons, miles)
    puts "Your car gets #{miles / gallons} miles per gallon."
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "Your car is a #{color} #{year} #{model}."
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  def to_s
    "Your truck is a #{color} #{year} #{model}."
  end
end



MyCar.mpg(20, 550)

jeep = MyCar.new(2024, 'blue', 'Jeep Grand Cherokee')
puts jeep

truck = MyTruck.new(2024, 'blue', 'Ford F150')
puts truck
