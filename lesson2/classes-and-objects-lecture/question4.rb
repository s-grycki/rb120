=begin
Using the class definition from step #3, let's create a few more people
-- that is, Person objects.

If we're trying to determine whether the two objects contain the same name,
how can we compare the two objects?
=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    create_full_name(name)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(name)
    create_full_name(name)
  end

  private

  def create_full_name(name)
    full_name = name.split
    @first_name = full_name.first
    @last_name = full_name.size == 1 ? '' : full_name.last
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
puts bob.name == rob.name
