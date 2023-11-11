=begin
Extra features to implement:
-Keep score of wins until a player reaches a certain number (and wins game)
-Add lizard and spock (5 options instead of 3)
-Add a class for each move?
-Keep track of move history for both players
-Implement personalities for each computer player
  Examples: R2D2 likes rock. Hal liks scissors but not paper

CONFIG OPTIONS
Allows user to override default settings, view options, or to start playing
Broken into 3 categories:
Config menu exclusive(functionality available before and after game)
- View computer player BIOs
- Change round win target for game win
Could have a shared dedicated menu to appear before and after a game

Game exclusive(functionaity only available during game)
- Last move shortcut key
- Move history
Could implement these as valid human inputs during game

Universal(always available)
- View time
- View rules
Needs to be avilable anytime a user can enter input (class for messages?)


KEEP SCORE
Need to loop until human or computer wins reaches a set value
Want to maintain loop to ask if user wants to play again after this
Player should have ability to set win requirement (config options)
Wins should be tracked as instances of Human/Computer objects
Win requirement should be tracked as instance of RPSGame

ADD LIZARD/SPOCK
Add these 2 values to valid VALUES
Could create 2 new boolean methods and add logic to </> methods
Should be tracked as instances of Move object

MAKE EACH MOVE A SEPERATE CLASS?
Each should be subclassed from Move
Fewer methods in Move in exchange for more classes (less "verbs" more "nouns")
Only using these moves as strings assigned to an instance variable
  Is it really worth it when implementation is already this simple?
  Conditional logic may get complex. I'll see then

KEEP TRACK OF HISTORY
Should set empty data structure at start of each game (hash or array)
Should be updated during each round
Makes sense to use array if tracked as instances of Human/Computer
Makes sense to use hash if tracked as single instance of Player
Needs to be accessible during game (e button)

IMPLEMENT COMPUTER PLAYER PERSONALITIES
Each computer "person" could be a class with set attributes
Could subclass directly from Player
Will be selected randomly from array of objects
Move choices shouldn't be entirely random. For example:
R2D2 likes rock. There's a 70% chance they'll choose rock
  But, there's a 30% chance R2D2 chooses something else

OOP PROBLEM SOLVING PROCESS:
Text description of Rock, Paper, Scissors, Lizard, Spock:
Rock, Paper, Scissors, Lizard, Spock is a two-player game where each player
chooses one of five possible moves: rock, paper, scissors, lizard or spock.
The chosen moves will then be compared to see who wins a round,
according to the following rules:

- rock beats scissors & lizard
- scissors beats paper & lizard
- paper beats rock & spock
- lizard beats spock & paper
- spock beats scissors & rock

If the players chose the same move, then it's a tie. The first player to a set
score wins the game

Before or after the game, the user can view the player bios of the computer
players and change the default game win target
(b/bios) for character bios
(w/wins) for win target

During the game, users can view the move history of both players and use a
shortcut to select their last choice
(h/history) for move history
(l/last) for last move

At any time, a user can view the time or rules of the game
(t/time) for current time
(r/rules) for rules

Major nouns and verbs:
Nouns(classes): 
Move(rock, paper, scissors, lizard, spock)
Player(Human and random computer player)
Win
Score
Player BIOs
Target
History
Choice
Time
Rules

Verbs(methods/behaviors): 
Choose
Compare
View
Select

Noun/verb associations:
Move
  -compare
Player
  -choose
Choice
  -select
History
  -view
Time
  -view
Rules
  -view
Player BIOs
  -view

Win
  Score
  Target
# Win based on comparing score with target (for whole game)
# Based on comparing choices (for round)
=end

# Writing nouns as classes and verbs as methods/behaviors (evolved from spike)
# Will refactor class heirarchy and UX after new functionality fully operational

require 'pry'
class Move
  VALUES = %w(rock paper scissors)

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :win_count

  def initialize
    set_name
    @win_count = 0
    @move_history = []
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ([R2d2, Hal, Chappie, Sonny, Number_5].sample).new.name
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end

  def display_bio; end
end

module Nameable
  attr_reader :name

  def initialize
    @name = self.class.to_s
  end
end

class R2d2
  include Nameable
  
  def initialize
    @name = 'R2D2'
  end

  def display_bio
    puts "R2D2 is the widely known and loved droid from Star wars. How does he
    play this game without any hands? It's actually utilized with R2's ability
    to project holograms outwards."
  end
end

class Hal
  include Nameable

  def display_bio
    puts "You may remember Hal as the whimsical dad from the American sitcom
    Malcolm in the Middle. He has recurring dreams where he shaves his head
    and makes a living off illicit activities in New Mexico."
  end
end

class Chappie
  include Nameable

  def display_bio
    puts "Daniel 'Chappie' James Jr. became the first African American 
    four-star general in 1975. His nickname was handed down to him by his
    brother. Chappie lived until 1978 at the age of 58."
  end
end

class Sonny
  include Nameable

  def display_bio
    puts "Sonny Capone is the son of famous American mobster Al Capone - who
    ruled a crime empire in Chicago. Unlike his father, Sonny, who changed his
    name later in life, lived a relatively quiet and drama-free life until his
    death at age 85 in the year 2004."
  end
end

class Number_5
  include Nameable

  def initialize
    @name = 'Number 5'
  end

  def display_bio
    puts "Number 5 was a star character in a Cartoon Network show called
    Codename Kid's Next Door. Though she prefers going by this codename most
    of the time, her real name is Abby."
  end
end

class History
  # Create new data structure to add info to
  # Be able to view this info
end

class New_Time
  # Create a time instance when called
  # Be able to view this info 
end

class Rules
  # Store text info on game rules
  # Be able to view this info
end

class Player_Bios
  # Store text info about players
  # Be able to view this info
end

# Orchestrate procedural flow of program using associations
class RPSGame
  attr_accessor :human, :computer, :win_requirement

  def initialize
    @human = Human.new
    @computer = Computer.new
    @win_requirement = 2 
    display_welcome_message
  end

  def clear_screen
    ((system "cls") | (system "clear")) # multiple OS support
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
    puts "Enter (rules/r) to view rules, shortcuts, and features"
    puts "Enter any other key to begin game"
    get_nongame_input
  end

  def get_nongame_input
    answer = gets.chomp.downcase
    case answer
    when 'rules', 'r' then display_rules
    when 'wins', 'w' then change_win_requirement
    when 'time', 't' then display_time
    when 'bios', 'b' then display_character_bios
    else play
    end
  end

  def display_rules
    rules = <<-HEREDOC
    Rock, Paper, Scissors, Lizard, Spock is a two-player game where each player
    chooses one of five possible moves: rock, paper, scissors, lizard or spock.
    The chosen moves will then be compared to see who wins a round,
    according to the following rules:

    - rock beats scissors & lizard
    - scissors beats paper & lizard
    - paper beats rock & spock
    - lizard beats spock & paper
    - spock beats scissors & rock

    If the players chose the same move, then it's a tie. The first player to a set
    score wins the game

    Before or after the game, the user can view the player bios of the computer
    players and change the default game win target
    (b/bios) for character bios
    (w/wins) for win target

    During the game, users can view the move history of both players and use a
    shortcut to select their last choice
    (h/history) for move history
    (l/last) for last move

    At any time, a user can view the time or rules of the game
    (t/time) for current time
    (r/rules) for rules
    HEREDOC

    puts rules
    gets
    display_welcome_message
  end

  def display_time
    puts Time.new.localtime
    gets
    display_welcome_message
  end
  
  def display_character_bios
    [R2d2, Hal, Chappie, Sonny, Number_5].each do |class_name|
      class_name.new.display_bio
    end
    gets
    display_welcome_message
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_round_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.win_count += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.win_count += 1
    else
      puts "It's a tie!"
    end
  end

  def display_win_count
    puts "#{human.name} has #{human.win_count} wins"
    puts "#{computer.name} has #{computer.win_count} wins"
  end

  def display_game_winner
    puts "#{human.name} wins!" if human.win_count >= win_requirement
    puts "#{computer.name} wins!" if computer.win_count >= win_requirement
  end

  def reset_wins
    human.win_count = 0
    computer.win_count = 0
  end 

  def play_again
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n w).include?(answer)
      puts "Sorry, must be y, n, or w."
    end

    case answer
    when 'y' then play
    when 'n' then display_goodbye_message 
    when 'w' then change_win_requirement
    end
  end

  def change_win_requirement
    answer = nil
    loop do
      puts 'How many games until a winner?'
      answer = gets.chomp
      break if answer.to_i >= 0
      puts 'Please enter a valid number'
    end

    self.win_requirement = answer.to_i
    display_welcome_message
  end

  def someone_won?
    (human.win_count >= win_requirement) ||
    computer.win_count >= win_requirement
  end

  def play
    until someone_won?
      binding.pry
      human.choose
      computer.choose
      display_moves
      display_round_winner
      display_win_count
    end

    display_game_winner
    reset_wins
    play_again

  end
end

# Start an "engine"
RPSGame.new.play
