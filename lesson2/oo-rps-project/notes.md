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
