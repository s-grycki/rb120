=begin
Create a sub-class from Dog called Bulldog overriding the swim method to
return "can't swim!"
=end


class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

buddy = Bulldog.new
puts buddy.speak
puts buddy.swim
