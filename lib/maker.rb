class Maker
  attr_reader :code
  def initialize(board)
    @code = []
    @board = board
  end

  def generate_code
    4.times do 
      @code << rand(1..6).to_s
    end
  end

  def put_key_pegs_board guess_sequence
    pegs = organize_key_pegs guess_sequence
    pegs_array = ("1"*pegs[:red] + "0"*pegs[:white]).split("")
    @board.add_key_pegs pegs_array
  end
  

  private
  def organize_key_pegs(guess_sequence)
    pegs = {red: 0, white: 0}
    for code_peg in ("1".."6")
        next unless guess_sequence.include? code_peg
        next unless @code.include? code_peg
        self.create_key_pegs guess_sequence, @code, code_peg, pegs
    end
    p pegs
    pegs
  end

  def select_matched_indexes sequence, code_peg
    sequence.each_index.select { |index| sequence[index] == code_peg }
  end

  def create_key_pegs guess_sequence, code_sequence, code_peg, pegs
    guess_matched_indexes = select_matched_indexes guess_sequence, code_peg
    code_matched_indexes = select_matched_indexes code_sequence, code_peg
    create_red_pegs guess_matched_indexes, code_matched_indexes, pegs
    create_white_pegs guess_matched_indexes, code_matched_indexes, pegs
  end
 

  def create_red_pegs guess_sequence_indexes, code_sequence_indexes, pegs
    # if both sequences have the same index, this is a red_peg
    red_pegs = guess_sequence_indexes & code_sequence_indexes
    unless red_pegs.empty?
      pegs[:red] += red_pegs.size
      # remove the red pegs indexes from sequences to not interfere on create_white_pegs
      guess_sequence_indexes.delete_if.with_index { |element, index| element == red_pegs[index] }
      code_sequence_indexes.delete_if.with_index { |element, index| element == red_pegs[index] }
    end
  end

  def create_white_pegs guess_sequence_indexes, code_sequence_indexes, pegs
    # check if still guesses to be considered
    unless guess_sequence_indexes.empty?
      pegs[:white] += (guess_sequence_indexes.size <= code_sequence_indexes.size) ? guess_sequence_indexes.size : code_sequence_indexes.size
    end 
    pegs
  end

end

