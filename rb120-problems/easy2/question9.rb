=begin
Now that we have a Walkable module, we are given a new challenge. Apparently 
some of our users are nobility, and the regular way of walking simply isn't 
good enough. Nobility need to strut.

We need a new class Noble that shows the title and name when walk is called:
byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

We must have access to both name and title because they are needed for other
purposes that we aren't showing here.
byron.name
=> "Byron"
byron.title
=> "Lord"
=end



module Moveable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
  include Moveable

  private

  def gait
    "strolls"
  end
end

class Cat
  include Moveable

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Moveable

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :title
  include Moveable

  def initialize(name, title)
    super(name)
    @title = title
  end

  def walk
    puts "#{title} #{name} #{gait} forward"
  end

  private

  def gait
    "struts"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"
puts byron.name
puts byron.title

