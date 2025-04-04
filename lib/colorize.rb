require 'rainbow'

module Colorize
  def self.colorize_peg peg
    case peg
      when "0" then Rainbow("0").white 
      when "1" then Rainbow("1").red
      when "2" then Rainbow("2").green
      when "3" then Rainbow("3").yellow
      when "4" then Rainbow("4").blue
      when "5" then Rainbow("5").magenta
      when "6" then Rainbow("6").cyan
    end
  end
end