# Given the following code...

bob = Person.new
bob.hi

# And the corresponding error message...

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how would you go about fixing it?



# What this is telling me is that the method hi is defined within the Person
# class, but it's set to private, which means the method cannot be accessed
# outside of the class definition. A way to fix this is by calling the hi
# method inside of a public method inside the class. As of Ruby 2.7, self
# can be used to access private methods, so it would look like: self.hi.
# Alternatively, we could also move hi to above the private method call,
# assuming the hi method doesn't reveal sensitive information
