=begin
Consider the following class definition:

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

There is nothing technically incorrect about this class, but the definition may
lead to problems in the future. How can this class be fixed to be resistant
to future problems?
=end

class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end

  private
  attr_accessor :database_handle
end

# This class is creating getter/setter methods for the @database_handle
# instance variable, yet I don't see where this is important to the code.
# If it's coming from a database, is it sensitive data that should be kept
# private? I would want to ask the original developer about the intent of this
# code first, but I would move it to private access for now. That way, it's
# not deleted, but it eliminates the possibility of outside access while in
# development. If it's unneeded completely, then I would just delete it
