require 'rainbow'

class Maker
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def put_key_pegs(guess_sequence)
    pegs = {red: 0, white: 0}
    guess_sequence_array = guess_sequence.split("")
    code_sequence = self.code.split("")
    for code_peg in ("1".."6")
        next unless guess_sequence_array.include? code_peg
        next unless code_sequence.include? code_peg
        create_key_pegs guess_sequence_array, code_sequence, code_peg, pegs
    end
    pegs
  end

  private
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
      guess_matched_indexes -= red_pegs
      code_matched_indexes -= red_pegs
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

maker = Maker.new("1333")
p maker.put_key_pegs("3111")