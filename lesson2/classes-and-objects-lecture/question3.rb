=begin
Now create a smart name= method that can take just a first name or a full name,
and knows how to set the first_name and last_name appropriately.
=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    full_name = name.split
    @first_name = full_name.first
    @last_name = full_name.size == 1 ? '' : full_name.last
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(name)
    full_name = name.split
    @first_name = full_name.first
    @last_name = full_name.size == 1 ? '' : full_name.last
  end
end

# Refactored to be more DRY
class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    create_full_name(name)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name=(name)
    create_full_name(name)
  end

  private

  def create_full_name(name)
    full_name = name.split
    @first_name = full_name.first
    @last_name = full_name.size == 1 ? '' : full_name.last
  end
end

bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
puts bob.first_name            # => 'John'
puts bob.last_name             # => 'Adams'
