# frozen_string_literal: true

# Class responsible for handling a game of Mastermind
# Using the colored pegs: Red, Orange, Yellow, Green, Blue, Purple
# Duplicate pegs are allowed in the secret code but blanks are not.
class Mastermind
  def initialize
    @legit_guess = 0
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
  end

  def guess
    puts 'Enter a 4 Letter Combo Consisting of the letters (r o y g b p)'
    @guess = gets.chomp.split(//)
    if @guess.length == 4 && (@guess - @colors).empty?
      puts "Move #{@move}"
      @move += 1
      @legit_guess = 1
    else
      puts 'Illegal Guess!'
      guess
    end
  end

  def legit_guess
    @legit_guess
  end

  def move
    @move
  end

  def game_won
    @game_won
  end

  def evaluate_guess
    @guess.each_with_index do |value, index|
      if value == @code[index]
        puts "Guess #{value} at position #{index} is correct!"
      elsif @code.include?(value)
        puts "Guess #{value} is present but not at location #{index}!"
      else
        puts "Guess #{value} is not present in the array!"
      end
    end
  end

  def check_victory
    return unless @guess == @code

    puts 'You have cracked the code!'
    @game_won = 1
  end
end

game = Mastermind.new
game.generate_code

while game.game_won.zero? && game.move <= 12
  game.guess
  game.evaluate_guess
  game.check_victory
end
