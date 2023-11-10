=begin
Correct the following program so it will work properly. Assume that the Car
class has a complete implementation; just make the smallest possible change
to ensure that cars have access to the drive method.
=end

module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

# Previous code was trying to use drive as a class method. This wouldn't make
# much sense because modules are included to extend functionality to classes
