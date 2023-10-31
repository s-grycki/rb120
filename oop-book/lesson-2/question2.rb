=begin
Add an accessor method to your MyCar class to change and view the color of
your car. Then add an accessor method that allows you to view,
but not modify, the year of your car.
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
end

car = MyCar.new(2024, 'blue', 'Grand Cherokee')
car.speed_up(30)
car.brake(10)
car.current_speed
car.shut_off

puts car.color
puts car.color = 'green' # equivalent to car.color=('green')
puts car.year
