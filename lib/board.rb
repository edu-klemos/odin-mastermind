require_relative 'peg.rb'

class Board
  attr_accessor :decode_board

  def initialize(rows)
    @decode_board = new_board rows
  end

  def draw_board
    draw = board_header
    self.decode_board.each.with_index(1) do |row, index|
      draw << row_string(row, index)
    end
    draw
  end

  def add_pegs round, code_pegs, key_pegs
    add_code_pegs round, code_pegs
    add_key_pegs round, key_pegs
  end

  private
  def new_board rows
    Array.new(rows) { {code_pegs: Peg.new, key_pegs: Peg.new} }
  end

  def add_code_pegs round, code_pegs
    self.decode_board[round-1][:code_pegs].sequence = code_pegs
  end

  def add_key_pegs round, key_pegs
    self.decode_board[round-1][:key_pegs].sequence = key_pegs
  end

  def board_header
    "\n     Code     |  Keys\n" + "-"*25
  end

  def row_string row, index
    "\n#{index} => #{row[:code_pegs].sequence}  |  #{row[:key_pegs].sequence}\n"
  end
end

board = Board.new(5)
board.add_pegs 1, "1234", "01"
board.add_pegs 2, "4561", "11"
puts board.draw_board