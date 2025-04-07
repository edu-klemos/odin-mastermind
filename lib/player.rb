class Player
  def initialize(board)
  @board = board
  end

  def put_code_sequence_board guess_sequence
    @board.add_code_pegs(guess_sequence)
  end
end