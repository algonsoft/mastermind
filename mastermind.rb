# frozen_string_literal: true

# Class responsible for handling a game of Mastermind where a Human guesses a computer generated code
# Using the colored pegs: Red, Orange, Yellow, Green, Blue, Purple
# Duplicate pegs are allowed in the secret code but blanks are not.
class Mastermind
  attr_accessor :legit_guess, :move, :game_won

  def initialize
    @legit_guess = 0
    @game_won = 0
    @move = 1
    @colors = %w[r o y g b p]
    @colors_string = "roygbp"
    @code = []
    @correct = 0
    @incorrect = 0
    @misplaced = 0
  end

  def generate_code
    4.times do
      rand_num = rand(@colors.length)
      @code.append(@colors[rand_num])
    end
  end

  def guess
    puts 'Enter a 4 Letter Combo Consisting of the letters (r o y g b p) to crack code'
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

  def evaluate_guess
    @guess.each_with_index do |value, index|
      if value == @code[index]
        @correct += 1
      elsif @code.none?(value)
        @incorrect += 1
      else
        @misplaced += 1
      end
    end
    puts "You have #{@correct} correctly placed pegs, #{@misplaced} misplaced pegs and #{@incorrect} incorrect pegs"
  end

  def reset_pegs
    @correct = 0
    @misplaced = 0
    @incorrect = 0
  end

  def check_victory
    return unless @computer_code == @code

    puts 'Code has been cracked!'
    @game_won = 1
  end
end

# Class for allowing the computer to guess codes for Mastermind!
class MastermindComputer < Mastermind
  def initialize
    super
    @computer_code = []
    @tried_guess = []
    @list = []
    @list2 = []
    @expended = []
    @correct_pop = 0
    @incorrect_pop = 0
    @misplaced_pop = 0
    @guess_array = []
  end

  def reset_move
    @move = 1
  end

  def human_generate_code
    puts 'Human Setting Code'
    puts 'Enter 4 Digit Code consisting of (r o y g b p)'
    @code = gets.chomp.split(//)
    if @code.length == 4 && (@code - @colors).empty?
      puts 'Legal code submitted!'
    else
      puts 'Illegal Code!'
      human_generate_code
    end
  end

  def computer_set_list
    @computer_code = []
    4.times do
      rand_num = rand(@colors.length)
      @computer_code.append(@colors[rand_num])
    end
    if @list.none?(@computer_code)
    @list.append(@computer_code)
    @move += 1
    else
      computer_set_list
    end
  end

  def computer_guess_code
    if @move == 1
      @computer_code = ['r','r','o','o']
      puts "Trying #{@computer_code}"
      @move += 1
    end
      if @computer_code[0] != @code[0]
        @computer_code[0] = @colors[rand(@colors.length)]
      end
      if @computer_code[1] != @code[1]
        @computer_code[1] = @colors[rand(@colors.length)]
      end
      if @computer_code[2] != @code[2]
        @computer_code[2] = @colors[rand(@colors.length)]
      end
      if @computer_code[3] != @code[3]
        @computer_code[3] = @colors[rand(@colors.length)]
      end
    end

  def computer_guess_code_random
    guess = rand(@list.length)
    @computer_code = @list[guess]
    end



  def computer_evaluate_guess
    @computer_code.each_with_index do |value, index|
      if value == @code[index]
        @correct += 1
      elsif @code.none?(value)
        @incorrect += 1
      else
        @misplaced += 1
      end
    end
    puts "CPU: has #{@correct} correctly placed pegs, #{@misplaced} misplaced pegs and #{@incorrect} incorrect pegs"
  end
end

choices = [1, 2]
puts 'Enter 1 to be Codebreaker or 2 to be Codemaker'
choice = gets.chomp.to_i until choices.include?(choice)

case choice
when 1
  game = Mastermind.new
  game.generate_code

  while game.game_won.zero? && game.move <= 12
    game.guess
    game.evaluate_guess
    game.check_victory
    game.reset_pegs
  end

when 2
  computer = MastermindComputer.new

  computer.computer_set_list while computer.move <= 1296
  computer.reset_move
  computer.human_generate_code
  while computer.game_won.zero?
    computer.computer_guess_code
    computer.computer_evaluate_guess
    computer.check_victory
    computer.reset_pegs
  end
end
