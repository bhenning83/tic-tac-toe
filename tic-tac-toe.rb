# Create a visual 3x3 grid with a number assigned to each cell
# Create two players
# alternate between the players asking them to select a cell to play
# If the number they pick has already been played, ask them to pick again
# Once a cell on the grid is picked by a player, change the number to either an X or an O
# Assign the player's selection to two arrays: one to keep track of all plays, and one to keep track of each individual player's plays 
# create a key with every possible winning combination
# After every turn, test the player's array against the winning combinations
# If the players array matches a winning combination, end the game and declare them the winner
require "pry"
class Game
  def initialize
    @@play_options = Array(1..9)
  end

  def create_board
    puts "#{@@play_options[0]} | #{@@play_options[1]} | #{@@play_options[2]}"
    puts "---------"
    puts "#{@@play_options[3]} | #{@@play_options[4]} | #{@@play_options[5]}"
    puts "---------"
    puts "#{@@play_options[6]} | #{@@play_options[7]} | #{@@play_options[8]}"
  end
end

class Player < Game
  attr_accessor :name

  def initialize(name)
    @name = name
    @play_log = []
  end

  def play_turn
    puts "Pick where you want to play"
    number_picked = gets.chomp.to_i
    @@play_options[number_picked - 1] = "X"
  end
end

player1 = Player.new("Brendon")
round1 = Game.new
round1.create_board
player1.play_turn
round1.create_board

  
