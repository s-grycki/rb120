=begin
Modify the class definition from above to facilitate the following methods. 
Note that there is no name= setter method now.
=end

class Person
  attr_accessor :last_name, :first_name

  def initialize(name)
    @first_name = name
    @last_name = ''
  end

  def name
    "#{first_name} #{last_name}"
  end 
end

bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'
