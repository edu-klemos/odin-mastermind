require_relative 'peg_sequence.rb'

class Board
  attr_accessor :decode_board
  attr_reader :remaining_rows

  def initialize(rows)
    @decode_board = new_board rows
    @remaining_rows = rows
  end

  def draw_board
    draw = board_header
    self.decode_board.each.with_index(1) do |row, index|
      draw << row_string(row, index)
    end
    draw
  end

  def add_code_pegs code_pegs
    self.decode_board[-@remaining_rows][:code_pegs].sequence = code_pegs
  end

  def add_key_pegs key_pegs
    self.decode_board[-@remaining_rows][:key_pegs].sequence = key_pegs
  end

  def last_key_pegs
    self.decode_board[-@remaining_rows - 1][:key_pegs].sequence
  end

  def next_row
    @remaining_rows -= 1
  end

  private
  def new_board rows
    Array.new(rows) { {code_pegs: PegSequence.new, key_pegs: PegSequence.new} }
  end

  def board_header
    "\n     Code     |  Keys\n" + "-"*25
  end

  def row_string row, index
    "\n#{index} => #{row[:code_pegs].sequence}  |  #{row[:key_pegs].sequence}\n"
  end
end