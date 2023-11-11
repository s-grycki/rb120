=begin
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

If the players chose the same move, then it's a tie.

The first player to a set score wins the game

Major nouns and verbs:
Nouns(classes): 
Move(rock, paper, scissors, lizard, spock)
Player(Human and random computer player)
Win
Rules
Score

Verbs(methods/behaviors): 
Choose
Compare

Noun/verb associations:
Move
  -compare
Player
  -choose
Win
Rules
Score

Extra features to implement:
-Keep score of wins until a player reaches a certain number (and wins game)
-Add lizard and spock (5 options instead of 3)
-Add a class for each move?
-Keep track of move history for both players
-Implement personalities for each computer player
  Examples: R2D2 likes rock. Hal liks scissors but not paper

CONFIG OPTIONS
Should allow user to enter set values for options or to start playing
q => see rules (should be functional at all times)
w => set win requirement (should be disabled during game)
e => see move history (should be functional during game and reset after)
Allow user to reset win requirement if they want to play again
This prompt should show up at execution run time

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


=end

# Writing nouns as classes and verbs as methods/behaviors (evolved from spike)

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
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
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

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
    puts "Press h during the game to view move history."
    puts "Press c to enter config menu."
    puts "Press any other key to begin the game"
  end

  def display_config_menu
    puts "Press w to change the win requirement."
    puts "Press t to see the time"
    puts "Press c to learn about computer players"
    puts "Press r to view the rules"
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
    play_again
  end

  def someone_won?
    (human.win_count >= win_requirement) ||
    computer.win_count >= win_requirement
  end

  def play
    until someone_won?
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
