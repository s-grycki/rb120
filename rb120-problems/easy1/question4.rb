=begin
Complete this program so that it produces the expected output:

class Book
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

Expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end

class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
p book.author # => nil
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# In this case, we do want to be able to get and set values outside of the
# class. Therefore, we should create both methods.




# Further Exploration:
# What do you think of this way of creating and initializing Book objects?
# (The two steps are separate.) Would it be better to create and initialize
# at the same time like in the previous exercise? What potential problems,
# if any, are introduced by separating the steps?

# We could have constructed these values while creating the object if we didn't
# want to give outside reassignment access, and honestly, I think this is
# usually the better way to go. What if we want to change permissions later on?
# If we tried to get a value of the bat, it's going to return nil because
# it hasn't been created yet. The average user of developer created code isn't
# going to know what this means. It's just giving them a value they don't want.
