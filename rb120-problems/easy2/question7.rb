=begin
Consider the following code:

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

Write the classes and methods that will be necessary to make this code run,
and print the following output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

The order of the output does not matter, so long as all of the information is
presented.

PROBLEM:
Construct new Pet objects with kind of animal and name of animal as strings
Construct new Owner objects with name of owners as string
Construct a new Shelter object

Use shelter object to adopt with Owner objects and Pet objects as arguments
Output all associated adoptions on their own lines
Output how many pets each person has adopted

Explicit Rule:
Output can be in any order

EXAMPLES:
phanson adopts butterscotch => {'P Hanson' => [butterscotch, ], [1]}
phanson adopts pudding => {'P Hanson' => [butterscotch, pudding], [2]}
phanson adopts darwin => {'P Hanson' => [butterscotch, pudding, darwin], [3]}

phanson.owner has adopted the following pets:
a butterscotch.animal named butterscotch.name
a pudding.animal named pudding.name
a darwin.animal named darwin.name

phanson.owner has 3 adopted pets


DATA STRUCTURES:
Input: 2 strings of animal and name(Pet), string of owner(Owner)
Intermediate: Hash with Owner name keys and array(s) with Pet objects and incrementing integer
Output: Each owner with a list of animals adopted. The number of animals adopted by each owner
Helper: @number_of_pets to increment integer when animal adopted


THOUGHTS:
number_of_pets is an instance variable of each Owner object
attr accessors need to be defined in the class we're accessing
these accessors must be public to be used inside other classes

ALGORITHM:
Create all given Pet objects
Create all given Owner objects
  Construct @number_of_pets to 0

Create a new Shelter object

Inside class Shelter
  Set @@owner_info to empty hash
  Create adopt instance method which accepts Owner and Pet objects as arguments
  If @@owner_info has key of Owner name
    Push Pet object onto first nested array value ({'P Hanson' => [butterscotch, pudding], [1]})
    Increment Owner object's number_of_pets state by 1 (phanson.number_of_pets = 2)
  Else
    Set @@owner_info[Owner name] equal to [Pet object] ({'P Hanson' => [butterscotch]})
    Increment Owner object's number_of_pets state by 1 (phanson.number_of_pets = 1)

  Create print_adoptions method
    Output each @@owner_info key ("P hanson...")
    Output state of each Pet object ("A cat named Butterscotch") ...

Output how many pets each person has (P Hanson has 3 adopted pets.)

=end



class Pet
  @@unadopted = []
  attr_reader :name, :animal

  def initialize(animal, name)
    @animal = animal
    @name = name
    @@unadopted << self
  end

  def self.unadopted_pets
    puts 'The Animal Shelter has the following unadopted pets:'
    @@unadopted.each { |pet| puts "a #{pet.animal} named #{pet.name}"}
  end

  def self.how_many_unadopted
    @@unadopted.size
  end

  private
  def self.adopted_pet(pet)
    @@unadopted.delete(pet)
  end
end

class Owner
  attr_accessor :number_of_pets
  attr_reader :name

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end
end

class Shelter
  @@owner_info = {}

  def adopt(owner_name, pet)
    @@owner_info[owner_name.name] ||= []
    @@owner_info[owner_name.name] << pet
    increment_count(owner_name)
    Pet.adopted_pet(pet)
  end

  def print_adoptions
    @@owner_info.each do |owner_name, pets|
      puts "#{owner_name} has adopted the following pets:"
      pets.each do |pet|
        puts "a #{pet.animal} named #{pet.name}"
      end
      puts "\n"
    end
  end

  private
  def increment_count(owner_name)
    owner_name.number_of_pets += 1
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
kitty        = Pet.new('cat', 'Kitty')
doggy        = Pet.new('dog', 'Doggy')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

Pet.unadopted_pets
puts "-------------------------------------"

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
sgrycki = Owner.new('S Grycki')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(sgrycki, kitty)
shelter.adopt(sgrycki, doggy)
shelter.print_adoptions
puts "-------------------------------------"
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{sgrycki.name} has #{sgrycki.number_of_pets} adopted pets."
puts "-------------------------------------"
puts "The Animal shelter has #{Pet.how_many_unadopted} unadopted pets."

# Further Exploration:
# Add your own name and pets to this project.

# Suppose the shelter has a number of not-yet-adopted pets, and wants to manage
# them through this same system. Thus, you should be able to add the following 
# output to the example output shown above:

=begin
The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell
   ...

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The Animal shelter has 7 unadopted pets.
=end

# Can you make these updates to your solution? Did you need to change your
# class system at all? Were you able to make all of your changes without
# modifying the existing interface?

=begin
PROBLEM:
Add your name and pets to the project (easy enough)

Track unadopted pets (more tricky)
Create additional new pets
Create a data structure to store all Pet instances (array - as class variable)
Start by listing all the pets (since none have been adopted yet)
Remove instance of Pet from data structure when adopted (access class variable from another class)
Count how many pets are left and output this

These implementations felt seamless with my existing code
=end
