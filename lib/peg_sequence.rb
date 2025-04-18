require_relative "colorize.rb"

class PegSequence
  def initialize
    @sequence = Array.new(4, "·")
  end

  def sequence=(new_sequence)
    new_sequence.each_with_index { |peg, index| @sequence[index] = Colorize::colorize_peg peg}
  end 

  def sequence
    @sequence.join(" ")
  end
end