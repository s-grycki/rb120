=begin
Create a module that you can mix in to ONE of your subclasses that describes 
a behavior unique to that subclass.
=end

module Loadable
  def under_max?(pounds)
    pounds < 3000
  end
end

class Vehicle
  attr_accessor :speed, :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
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

  def self.number_of_vehicles
    puts "You have #{@@number_of_vehicles} vehicles"
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
  include Loadable

  def to_s
    "Your truck is a #{color} #{year} #{model}."
  end
end



MyCar.mpg(20, 550)

jeep = MyCar.new(2024, 'blue', 'Jeep Grand Cherokee')
puts jeep

truck = MyTruck.new(2024, 'blue', 'Ford F150')
puts truck

Vehicle.number_of_vehicles

puts truck.under_max?(2000)
