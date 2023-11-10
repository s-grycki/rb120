=begin
Assume you have the following code:

class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

and this output:
Home 1 is cheaper
Home 2 is more expensive

Modify the House class so that the above program will work. You are permitted
to define only one new method in House.
=end


class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1.price < home2.price
puts "Home 2 is more expensive" if home2.price > home1.price
# A simple solution is to just call price on home1 and home2 so 2 valid
# comparisons are being made. But we violated the rule to only modify the
# House class




class House
  attr_reader :price
  include Comparable

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1
# This is where we introduce the Comparable module. Notice how we changed the
# name of our method. This is because our class MUST define the spaceship
# operator to use comparison behavior. Try renaming the method and notice the
# error you get. If you try to call the method directly, a bug occurs
# where we can flip the values and still get the same output - because it will
# always return a truthy value unless it's nil. What's happening here is </>
# are actually method calls that are syntatically pretty to look at. This
# method is searched for in class House, then is found in module Comparable.
# This module is already included in Numeric classes, but we added it to our
# custom class. The comparable module is looking for a <=> method. We don't
# want to call this method directly or else it won't reach the Comparable
# functionality


# Further Exploration:
# Is the technique we employ here to make House objects comparable a good one?
# (Hint: is there a natural way to compare Houses? Is price the only criteria you might use?)
# What problems might you run into, if any? Can you think of any sort of 
# classes where including Comparable is a good idea?

# Generally speaking, I don't think this is a good idea unless we ONLY ever
# want to compare home prices of House objects. We're overwriting default
# behavior for Numeric classes. What if a class needs to inhereit from House?
# Do we want this behavior impacting the method lookup chain? Why not have
# seperate functionality to compare housing prices?
