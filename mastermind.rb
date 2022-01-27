# frozen_string_literal: true

# Class responsible for handling a game of Mastermind
# Using the colored pegs: Red, Orange, Yellow, Green, Blue, Purple
# Duplicate pegs are allowed in the secret code but blanks are not.
class Mastermind
  def initialize
    @game_won = 0
    @move = 1
    @colors = %w[r o y g b p]
    @colors_string = "roygbp"
    @code = []
  end

  def generate_code
    4.times do
      rand_num = rand(@colors.length)
      @code.append(@colors[rand_num])
    end
    puts @code
  end

  def guess
    puts 'Enter a 4 Letter Combo Consisting of the letters (r o y g b p)'
    guess = gets.chomp.split(//)
    if guess.length == 4 && (guess - @colors).empty?
      puts 'Legitimate Guess'
      @move += 1
    else
      puts 'Incorrect Guess Try Again'
    end
  end

  def check_victory
    puts '...'
  end
end

game = Mastermind.new
game.generate_code

while @game_won.zero?
game.guess
end
