=begin
Write a method called age that calls a private method to calculate the age of 
the vehicle. Make sure the private method is not available from outside of 
the class. You'll need to use Ruby's built-in Time class to help.

Write method age
  Call private method to calculate age of vehicle
=end


module Loadable
  def under_max?(pounds)
    pounds.to_i < 3000
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

  def age
    puts "Your #{self.model} is #{current_age} years old"
  end

  private

  def current_age
    (Time.now.year + 1) - self.year.to_i
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



jeep = MyCar.new(2018, 'blue', 'Jeep Grand Cherokee')
truck = MyTruck.new(2022, 'red', 'Ford F150')

jeep.age
truck.age
