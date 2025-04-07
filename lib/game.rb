require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'maker.rb'
require_relative "colorize.rb"

class Game
  MAX_TURNS = 12

  def initialize
    @board = Board.new MAX_TURNS
    @player = Player.new @board
    @maker = Maker.new @board
  end

  def play
    @maker.generate_code
    p @maker.code

    MAX_TURNS.times do
      self.play_round
      return self.player_win if self.win_condition
    end
    self.player_lose
  end

  private
  def play_round
    guess_sequence = self.get_valid_code_input
    @player.put_code_sequence_board guess_sequence
    @maker.put_key_pegs_board guess_sequence
    @board.next_row
    puts @board.draw_board
  end

  def get_valid_code_input
    code = ""
    loop do
      puts "Enter a code sequence: "
      code = gets.chomp
      break if self.number_range_and_size_four? code
      puts "Code must contain only numbers and size 4 ex: 1234"
    end
    code.split("")
  end

  def number_range_and_size_four? code
    code.scan(/[^1-6]/).empty? && code.size == 4
  end

  def player_lose
    puts @board.draw_board
    puts "You lose :("
    puts "The code was: #{self.code_with_colors}"
  end

  def player_win
    puts "You win :)"
    puts "You solved the code #{self.code_with_colors}"
  end

  def code_with_colors
    Colorize::colorize_array @maker.code
  end

  def win_condition
    # 1 1 1 1 == all red pegs
    Colorize::remove_color(@board.last_key_pegs) == "1 1 1 1"
  end

end

game = Game.new
game.play