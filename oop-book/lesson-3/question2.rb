=begin
Override the to_s method to create a user friendly print out of your object.
=end

class MyCar
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

  def to_s
    "Your car is a #{color} #{year} #{model}."
  end
end

MyCar.mpg(20, 550)
jeep = MyCar.new(2024, 'blue', 'Jeep Grand Cherokee')
puts jeep

# By default, to_s is implicitly called on the argument of puts or with string
# interpolation. The Object#to_s method shows the class name of the object and
# the object id encoding. By creating our own instance method called to_s, we
# can overwrite this default behavior for objects of the MyCar class due to it
# being reached first in the method lookup chain

# Though using string interpolation, this uses the Object#to_s method, because
# it returns an instance variable pointing to a string object
