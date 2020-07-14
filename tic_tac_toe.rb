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

module BoardCreation
  @@play_options = Array(1..9)
  @@winning_combos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  @@combined_play_log = []

  def create_board
    puts "#{@@play_options[0]} | #{@@play_options[1]} | #{@@play_options[2]}"
    puts "---------"
    puts "#{@@play_options[3]} | #{@@play_options[4]} | #{@@play_options[5]}"
    puts "---------"
    puts "#{@@play_options[6]} | #{@@play_options[7]} | #{@@play_options[8]}"
  end
end

class Player
  include BoardCreation
  attr_accessor :name, :symbol, :play_log

  def initialize(name, symbol)
    self.name = name
    self.symbol = symbol
    self.play_log = []
  end

  def play_turn
    puts
    puts "Your turn, #{self.name}. Where do you want to play?"
    puts
    create_board
    puts
    number_picked = gets.chomp.to_i
    until !@@combined_play_log.include?(number_picked) && number_picked.between?(1, 9) do #Ensures number_picked is between 1-9 and hasn't already been played
      puts "Pick an open spot on the board"
      number_picked = gets.chomp.to_i
    end
    @@play_options[number_picked - 1] = self.symbol
    self.play_log.push(number_picked) #keeps track of a player's plays
    @@combined_play_log.push(number_picked) #keeps track of all plays so no number can be repeated
    puts " "
  end

  def check_for_winner
    results = []
    @@winning_combos.each do |combo|
      result = combo.all? { |number| self.play_log.include?(number) }
      results.push(result)
    end
    results.include?(true)
  end
end

class PlayGame < Player
  def initialize
    puts "Player 1, what's your name?"
    @player1 = Player.new(gets.chomp, "X")
    puts "You'll be X's, #{@player1.name}."
    puts
    puts "Player2, what's your name?"
    @player2 = Player.new(gets.chomp, "O")
    puts "You'll be O's, #{@player2.name}. That sucks."
    puts
  end

  def start_game
    for i in 1..9
      if i.odd?
        @player1.play_turn
        if @player1.check_for_winner == true
          puts
          puts "#{@player1.name} wins! #{@player2.name} is a loser!"
          puts
          create_board
          break
        end
      else
        @player2.play_turn
        @player2.check_for_winner
        if @player2.check_for_winner == true
          puts
          puts "#{@player2.name} wins! #{@player1.name} is a loser!"
          puts
          create_board
          break
        end
      end
      puts "CAT!"
    end
  end
end

first_game = PlayGame.new
first_game.start_game