=begin
Consider the following classes:

class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end

Refactor these classes so they all use a common superclass, and inherit
behavior as needed.
=end

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    self.class::WHEEL_COUNT
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  WHEELS = 4
end

class Motorcycle < Vehicle
  WHEELS = 2
end

class Truck < Vehicle
  WHEELS = 6
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end

# Further Exploration:
# Would it make sense to define a wheels method in Vehicle even though all of
# the remaining classes would be overriding it? Why or why not? If you think
# it does make sense, what method body would you write?

# This is an option. The route I went was to create a wheels method in the
# superclass that would return the class of the calling object and access a
# constant with the number of wheels. This is more DRY than writing the same
# method multiple times
