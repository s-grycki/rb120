=begin
You want to create a nice interface that allows you to accurately describe 
the action you want your program to perform. Create a method called 
spray_paint that can be called on an object and will modify the color of the car.
=end


class MyCar
  attr_accessor :speed, :color
  attr_reader :year

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
end

car = MyCar.new(2024, 'blue', 'Grand Cherokee')
car.speed_up(30)
car.brake(10)
car.current_speed
car.shut_off

puts car.color
puts car.color = 'green' # equivalent to car.color=('green')
car.spray_paint('blue')
puts car.year
