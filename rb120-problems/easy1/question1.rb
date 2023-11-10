=begin
Behold this incomplete class for constructing boxed banners.

class Banner
  def initialize(message)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
  end

  def empty_line
  end

  def message_line
    "| #{@message} |"
  end
end

Complete this class so that the test cases shown below work as intended.
You are free to add any methods or instance variables you need.
However, do not make the implementation details public.

You may assume that the input will always fit in your terminal window.


PROBLEM:
Complete a class for constructing boxed banners
Input: A string message
Output: A text box with message centered

Explicit Rules:
Do not make implementation details public
Assume input will always fit in terminal window

Implicit Rules:
Banner objects have default to_s method overwriten to display text box
message_line already created

EXAMPLES:
banner = Banner.new('To boldly go where no one has gone before.')
'+'('-' * message size + 2)'+'
'|'(' ' * message size + 2)'|'
'|'(' ' + message + ' ')'|'
'|'(' ' * message size + 2)'|'
'+'('-' * message size + 2)'+'
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

DATA STRUCTURES:
Input: String of characters
Intermediate: Array with string elements to represent individual lines
Output: String as text box with message centered
Helper: -

THOUGHTS:
message size + 2 seems like something which can be reused

ALGORITHM:
Contruct instance variables
Complete getter methods for associated instance variables



class Banner
  def initialize(message)
    @padding = message.size + 2
    @horizontal_rule = "+#{'-' * @padding}+"
    @empty_line = "|#{' ' * @padding}|"
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    @horizontal_rule
  end

  def empty_line
    @empty_line
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner
=end


# Refactored answer (just use method calls as constrcutors)
class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def empty_line
    "| #{' ' * (@message.size)} |"
  end

  def horizontal_rule
    "+-#{'-' * (@message.size)}-+"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner = Banner.new('')
puts banner



# Further Exploration
=begin
Modify this class so new will optionally let you specify a fixed banner width
at the time the Banner object is created. The message in the banner should be
centered within the banner of that width. Decide for yourself how you want to
handle widths that are either too narrow or too wide.

PROBLEM:
Long messages can look awkward or break the box entirely
I think setting a max line size to 80 is a good idea

THOUGHTS:
Take the text string and split it into array elements of 76 characters
Last array element still needs to be centered based on padding
Should break into helper methods

EXAMPLE:
+------------------------------------------------------------------------------+
|                                                                              |
| This is a really long message that I only used to test this program. There i |
| s no point in reading this, but if you are, then hello. I hope that you are  |
| doing well. Now then, how am I going to format this message so it looks less |
|                            awkward in a text box?                            |
|                                                                              |
+------------------------------------------------------------------------------+

=end

class Banner
  def initialize(message, width = message.size)
    @message = message
    @padding = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def empty_line
    "| #{' ' * (@padding)} |"
  end

  def horizontal_rule
    "+-#{'-' * (@padding)}-+"
  end

  def message_line
    @message.size <= @padding ? "| #{@message} |" : split_message
  end

  def split_message
    counter = 0
    line_arr = []
    populate_arr(counter, line_arr)
  end

  def populate_arr(counter, line_arr)
    @message.chars.each_with_object([]) do |char, msg_arr|
      line_arr << char
      counter += 1

      if max_size?(counter)
        line_arr = push_new_line(msg_arr, line_arr)
      elsif end_of_string?(counter)
        push_final_line(msg_arr, line_arr)
      end

    end
  end

  def max_size?(counter)
    counter % @padding == 0
  end

  def end_of_string?(counter)
    counter == @message.size
  end

  def push_new_line(msg_arr, line_arr)
    msg_arr << "| #{line_arr.join} |"
    []
  end

  def push_final_line(msg_arr, line_arr)
    msg_arr << "| #{line_arr.join.center(@padding)} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 21)
puts banner

banner = Banner.new('')
puts banner

banner = Banner.new('This is a really long message that I only used to test this program. There is no point in reading this, but if you are, then hello. I hope that you are doing well. Now then, how am I going to format this message so it looks less awkward in a text box?', 76)
puts banner
