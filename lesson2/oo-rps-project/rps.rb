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
- Move history
Could implement as valid human input during game

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

During the game, users can view the move history of both players and view the
bio of the current computer player
(h/history) for move history
(b/bio) for (individual) character bio

At any time, a user can view the time or rules of the game
(t/time) for current time
(rules) for rules *reserving r shortcut for rock

Basic Procedure:
Pre-Game(behavior only on initial bootup)
Create a new human player
Create a new computer player
Set an initial win requirement

Display the welcome message
Allow for pregame configuration if certain strings input
and return to welcome message
Else begin game

Game(dynamic behavior during rounds)
Ask human for game choice
Set move of human to input if rock, paper, scissors, lizard, or spock
Add move to human move history
Display option if valid option input(history, time, rules, bio)
and reprompt for input until valid move
Display error if invalid input and reprompt for input until valid move

Set move of computer to random move choice
Add move to computer move history

Display the moves picked by both human and computer

Compare moves
Display player won if their move beats computer
and increment player win count by 1
Display computer won if their move beats player
and increment computer win count by 1
Display tie if neither win

Display current game win count
Perform another round unless player or computer has win count of requirement

Post Game(behavior after every game)
Display the player who reached the win requirement with a victory message

Ask if human wants to play again
If so, then reset wins and repeat process starting at main game
Else display exit message and quit program

Preliminary Associations:
Displayable Messages
  welcome message
  errors
  time
  bios
  history
  rules
  human win count
  computer win count
  human wins round
  computer wins round
  game winner
  play again?

Promptable Inputs (Human exclusive behavior)
  welcome input
  game input
  post game input

Player
  move history

Human < Player
  name
  win count
  current move
  move history

Computer < Player
  win count
  current move
  move history
  name

Game
  win requirement
  compare moves

# Created UML Diagram here
=end

# Writing nouns as classes and verbs as methods/behaviors (evolved from spike)

require 'yaml'
MESSAGES = YAML.load_file('rps_messages.yml')

module Displayable
  def clear_screen
    ((system "cls") | (system "clear")) # multiple OS support
  end

  def display_error(error)
    messages = {
      name: 'Please enter a valid name',
      integer: 'Please enter a valid number greater than 0',
      move: 'Please enter a valid game move'
    }

    puts messages[error]
  end

  def display_time
    puts Time.new
    gets
  end

  def display_rules
    puts MESSAGES['rules']
    gets
  end

  def display_win_count
    puts "#{human.name} has #{human.wins} wins"
    puts "#{computer.name} has #{computer.wins} wins"
  end

  def display_round_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_game_winner
    puts "#{human.name} wins!" if human.wins >= RPSGame.target
    puts "#{computer.name} wins!" if computer.wins >= RPSGame.target
  end

  def display_history
    RPSGame.history.each do |name, moves|
      puts "#{name} has made the moves: #{moves.join(', ')}"
    end
    gets
  end

  def display_bio(name)
    puts MESSAGES['bios'][name.to_s]
    gets
  end

  def display_moves
    puts "#{human.name} chose: #{human.move}"
    puts "#{computer.name} chose: #{computer.move}"
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye #{human.name}!"
  end
end

module Answerable
  def clear_screen
    ((system "cls") | (system "clear")) # multiple OS support
  end

  def pregame_input
    loop do
      clear_screen
      puts "Welcome to Rock, Paper, Scissors, Lizard, Spock #{name}!"
      puts MESSAGES['pregame']
      answer = gets.chomp.downcase
      valid_nongame_option?(answer) ? call_options(answer) : break
    end
  end

  def change_target
    loop do
      puts "The current target is #{RPSGame.target}"
      puts "What would you like to change it to?"
      answer = gets.chomp.to_i
      RPSGame.update_target(answer) if answer > 0
      break if answer > 0
      display_error(:integer)
    end
  end

  def play_again?
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      call_options(answer) if valid_nongame_option?(answer)
      return true if answer.match?(/\A(y|yes)\z/)
      return false if answer.match?(/\A(n|no)\z/)
      puts "Sorry, must answer yes or no." if !valid_nongame_option?(answer)
    end
  end

  def valid_nongame_option?(answer)
    answer.match?(/\A(ru|rules|t|time|w|wins|b|bio|c|clear|h|history)\z/)
  end

  def yes_or_no?(answer)
    answer.match?(/\A(y|yes|no|n)\z/)
  end

  def call_options(answer)
    case answer
    when 'ru', 'rules' then display_rules
    when 't', 'time' then display_time
    when 'w', 'wins' then change_target
    when 'b', 'bio' then display_bio(Computer.name)
    when 'h', 'history' then display_history
    when 'c', 'clear' then RPSGame.clear_history
    end
  end
end

class Move
  attr_reader :value

  def >(other_move)
    MESSAGES['moves'][value].include?(other_move.value)
  end

  def <(other_move)
    MESSAGES['moves'][other_move.value].include?(value)
  end

  def to_s
    @value
  end

  private

  def initialize(value)
    value = convert_input(value) if shorthand?(value)
    @value = value
  end

  def convert_input(value)
    conversions = {
      'r' => 'rock',
      'p' => 'paper',
      'sc' => 'scissors',
      'l' => 'lizard',
      'sp' => 'spock'
    }

    conversions[value]
  end

  def shorthand?(value)
    %w(r p sc l sp).include?(value)
  end
end

class Player
  attr_accessor :name, :wins, :move

  private

  def initialize
    set_name
    @wins = 0
  end
end

class Human < Player
  def choose
    loop do
      puts 'Please enter rock, paper, scissors, lizard or spock:'
      answer = gets.chomp.downcase
      clear_screen
      validate_choice(answer)
      break if valid_move?(answer)
    end
  end

  def self.name
    @@name
  end

  private

  include Displayable
  include Answerable

  def initialize
    super
    @@name = name
  end

  def set_name
    loop do
      puts 'Please enter your name:'
      answer = gets.chomp
      answer = valid_name?(answer) ? format_name(answer) : display_error(:name)
      break unless answer.nil?
    end
  end

  def format_name(answer)
    self.name = answer.split.map(&:capitalize).join(' ')
  end

  def valid_name?(answer)
    answer.match?(/\A[a-z]+/i)
  end

  def validate_choice(answer)
    if valid_move?(answer)
      self.move = Move.new(answer)
      RPSGame.update_history(name, move.value)
    elsif valid_game_option?(answer)
      call_options(answer)
    else
      display_error(:move)
    end
  end

  def valid_move?(answer)
    answer.match?(/\A(r|rock|p|paper|sc|scissors|l|lizard|sp|spock)\z/)
  end

  def valid_game_option?(answer)
    answer.match?(/\A(ru|rules|t|time|b|bio|h|history|c|clear)\z/)
  end
end

class Computer < Player
  def self.name
    @@name
  end

  private

  def initialize
    super
    @@name = name
  end

  def set_name
    self.name = self.class.to_s
  end

  def make_move(answer)
    self.move = Move.new(answer)
    RPSGame.update_history(name, move.value)
  end
end

class R2D2 < Computer
  def choose
    choice = case rand(101)
             when 0..70 then 'rock'
             when 71..85 then 'paper'
             when 86..90 then 'lizard'
             when 91..100 then 'spock'
             end

    make_move(choice)
  end
end

class Hal < Computer
  def choose
    choice = case rand(101)
             when 0..20 then 'rock'
             when 21..30 then 'paper'
             when 31..90 then 'scissors'
             when 91..100 then 'lizard'
             end

    make_move(choice)
  end
end

class Chappie < Computer
  def choose
    choice = case rand(101)
             when 0..25 then 'rock'
             when 26..35 then 'paper'
             when 36..40 then 'scissors'
             when 41..100 then 'spock'
             end

    make_move(choice)
  end
end

class Sonny < Computer
  def choose
    choice = case rand(101)
             when 0..50 then 'paper'
             when 51..65 then 'scissors'
             when 66..80 then 'lizard'
             when 81..100 then 'spock'
             end

    make_move(choice)
  end
end

class Number5 < Computer
  def choose
    choice = case rand(101)
             when 0..5 then 'rock'
             when 6..15 then 'scissors'
             when 16..80 then 'lizard'
             when 81..100 then 'spock'
             end

    make_move(choice)
  end
end

# Orchestrate procedural flow of program using associations
class RPSGame
  def play
    pregame
    game until someone_won?
    postgame
  end

  def self.history
    @@history
  end

  def self.update_history(name, move)
    history[name] << move
  end

  def self.clear_history
    @@history = { Human.name => [], Computer.name => [] }
  end

  def self.target
    @@target
  end

  def self.update_target(answer)
    @@target = answer
  end

  private

  include Displayable
  include Answerable

  attr_accessor :human, :computer

  @@target = 3

  def initialize
    @human = Human.new
    @computer = Computer.subclasses.sample.new
    @@history = { human.name => [], computer.name => [] }
  end

  def increment_win_count
    human.wins += 1 if human.move > computer.move
    computer.wins += 1 if human.move < computer.move
  end

  def someone_won?
    (human.wins >= RPSGame.target) || (computer.wins >= RPSGame.target)
  end

  def reset_wins
    human.wins = 0
    computer.wins = 0
  end

  def pregame
    human.pregame_input
  end

  def game
    human.choose
    computer.choose
    display_moves
    display_round_winner
    increment_win_count
    display_win_count
  end

  def postgame
    display_game_winner
    reset_wins
    answer = human.play_again?
    answer ? play : display_goodbye_message
  end
end

# Start an "engine"
RPSGame.new.play
