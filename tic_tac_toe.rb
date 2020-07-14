module BoardCreation
  @@play_options = Array(1..9)
  @@winning_combos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  @@combined_play_log = []

  def create_board
    puts "#{@@play_options[0]} | #{@@play_options[1]} | #{@@play_options[2]}"
    puts '---------'
    puts "#{@@play_options[3]} | #{@@play_options[4]} | #{@@play_options[5]}"
    puts '---------'
    puts "#{@@play_options[6]} | #{@@play_options[7]} | #{@@play_options[8]}"
  end

  def update_board
    @@play_options[@number_picked - 1] = symbol
    play_log.push(@number_picked) # keeps track of a player's plays
    @@combined_play_log.push(@number_picked) # keeps track of all plays so no number can be repeated
    puts
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
    puts "Your turn, #{name}. Where do you want to play?"
    puts
    create_board
    puts
    @number_picked = gets.chomp.to_i
    # Ensures number_picked is between 1-9 and hasn't already been played
    until !@@combined_play_log.include?(@number_picked) && @number_picked.between?(1, 9)
      puts 'Pick an open spot on the board'
      @number_picked = gets.chomp.to_i
    end
    update_board
  end

  def check_for_winner
    results = []
    @@winning_combos.each do |combo|
      result = combo.all? { |number| play_log.include?(number) }
      results.push(result)
    end
    results.include?(true)
  end
end

class PlayGame < Player
  def initialize
    puts "Player 1, what's your name?"
    @player1 = Player.new(gets.chomp, 'X')
    puts "You'll be X's, #{@player1.name}."
    puts
    puts "Player2, what's your name?"
    @player2 = Player.new(gets.chomp, 'O')
    puts "You'll be O's, #{@player2.name}. That sucks."
    puts
  end

  def winner_announcement(winner)
    puts
    puts "#{winner.name} wins!"
    puts
    create_board
    puts
    exit!
  end

  def start_game
    (1..9).each do |i|
      if i.odd?
        @player1.play_turn
        winner_announcement(@player1) if @player1.check_for_winner == true
      else
        @player2.play_turn
        winner_announcement(@player2) if @player2.check_for_winner == true
      end
    end
    puts 'CAT!'
  end
end

new_game = PlayGame.new
new_game.start_game
