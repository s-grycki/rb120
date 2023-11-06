=begin
Draw a class hierarchy diagram of the classes from step #2
=end

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

# Pet => Dog
# Pet => Cat
# Dog => Bulldog

=begin
            Pet
            run
            jumo
          /      \
        /         \
      Dog         Cat
      speak       speak
      fetch
      swim
       |
       |
      Bulldog
      swim
end
