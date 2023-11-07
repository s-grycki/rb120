=begin
Using the following code, determine the lookup path used when invoking
cat1.color. Only list the classes and modules that Ruby will check when
searching for the #color method.
=end

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
p cat1.class.ancestors # => [Cat, Animal, Object, Kernel, BasicObject]
cat1.color
# It goes all the way up the method lookup chain and finds no valid method.
# Therefore, we get an error

