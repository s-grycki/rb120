=begin
What will the following code print?
=end

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata # => ByeBye
puts thing.dupdata # => HelloHello

# We create thing as a new instance of Something. This is constructed with the
# instance variable @data which is assigned to string 'Hello'

# On the next line, we call a class method which returns 'ByeBye'

# Finally, we call the instance method dupdata on thing which returns the
# instance variable @data concatenated with itself for 'HelloHello'
