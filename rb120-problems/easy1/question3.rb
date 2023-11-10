=begin
Complete this program so that it produces the expected output:

class Book
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

Expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end



class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Originally, the program was trying to access getter methods that weren't
# defined. This is easily solved by adding them in



# Further Exploration:
# What are the differences between attr_reader, attr_writer, and attr_accessor?
# Why did we use attr_reader instead of one of the other two? Would it be okay
# to use one of the others? Why or why not?

# attr_reader creates getter methods. It's like reading.
# attr_writer creates setter methods. It's like writing.
# attr_accessor creates both methods at once.
# attr_reader was used because this program only needed to read an attribute.
# It COULD be okay to use attr_accessor, but it creates a new point of 
# accidental data manipulation. In addition, what if the program is storing
# sensitive data and we don't want people to change this data without higher
# access privilage? It's best to stick with what's needed



# Instead of attr_reader, suppose you had added the following methods to this
# class:
# Would this change the behavior of the class in any way? If so, how? If not,
# why not? Can you think of any advantages of this code?

def title
  @title
end

def author
  @author
end
# These represent getter methods in a non-shorthand manner. It wouldn't change
# anything in the above example, because it's the default behavior. A potential
# advantage of doing it this way is that it gives implementation flexibility.
# What if we wanted these values returned to be formated differently throughout
# the program?
