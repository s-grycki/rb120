=begin
Consider the following broken code:

class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

Modify this code so it works. Do not make the amount in the wallet accessible
to any method that isn't part of the Wallet class.
=end



class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected
  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# The original code was trying access a local variable named amount. This is
# easily fixed by including a getter method for the @amount instance variable.
# The important other requirement is that we don't want the amount of money in
# a person's wallet to be seen outside of the class. However, we do want any
# instance of the wallet class to be able to access amount - not just self.
# Therefore, the access level should be protected

# Further Exploration:
# This example is rather contrived and unrealistic, but this type of situation
# occurs frequently in applications. Can you think of any applications where
# protected methods would be desirable?

# I think an application where you have data that shouldn't be part of the
# public interface, but you need more flexibility than just calling self with
# the method, such as when we need to compare self with another instance of the
# same class, is when we should use protected access rights. An example is
# grading a test. We need a given answer and the guarenteed correct answer
# compared each time, but we don't want student nor given answers to be
# freely available for viewing
