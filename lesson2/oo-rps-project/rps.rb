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
      integer: 'Please enter a valid number between 1 and 100',
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
  NONGAME_OPTIONS = %w(ru rules t time w wins b bio c clear h history)

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
      RPSGame.update_target(answer) if answer.between?(1, 100)
      break if answer.between?(1, 100)
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
    NONGAME_OPTIONS.include?(answer)
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
  def initialize(value)
    value = convert_input(value) if shorthand?(value)
    @value = value
  end

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
  def initialize
    set_name
    @wins = 0
  end

  attr_accessor :name, :wins, :move
end

class Human < Player
  VALID_MOVE = %w(r rock p paper sc scissors l lizard sp spock)
  GAME_OPTIONS = %w(ru rules t time b bio h history c clear)

  def initialize
    super
    @@name = name
  end

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
    VALID_MOVE.include?(answer)
  end

  def valid_game_option?(answer)
    GAME_OPTIONS.include?(answer)
  end
end

class Computer < Player
  def initialize
    super
    @@name = name
  end

  def self.name
    @@name
  end

  private

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
  def initialize
    @human = Human.new
    @computer = Computer.subclasses.sample.new
    @@history = { human.name => [], computer.name => [] }
  end

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
