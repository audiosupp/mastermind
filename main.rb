require_relative 'board'
require_relative 'random_colors'
require_relative 'mastermindAI'

board = Board.new
match = false

class Computer
  include RandomColor

  attr_reader :memory
  def initialize
    @memory = []
    @choose = []
    @random_numbers = []
    @numbers_in_position = []
  end

  def choose
    choice = []
    @random_numbers.each do |num|
      choice << num
    end
    @numbers_in_position.each do |num|
      choice << num
    end
    remaining_size = 4 - choice.size
    remaining_size.times do
      choice << rand(1..8)
    end
    #choice.shuffle!
    @memory << choice
    @choose = choice
  end

  def read_output(output, index)
    number_of_o = output.count('O')
    @random_numbers = number_of_o.times.map { @memory[index - 1].sample }
    number_of_x = output.count('X')
    @numbers_in_position = number_of_x.times.map { @memory[index - 1].sample }
    @random_numbers.uniq!
    @numbers_in_position.uniq!
  end
end

#ai = Computer.new

masterAI = MastermindAI.new([1,2,3,4,5,6,7,8], 4)

until match
  # p ai.choose
  # p ai.memory
  #p board.winning_position
  board.display
  puts 'guess colors'
  guess = masterAI.initial_guess
  input = gets.chomp.each_char.map(&:to_i)
  if board.make_move(input)
    board.calculate_feedback(input)
    #index = board.current_row
    #p board.calculate_feedback(guess)
    #masterAI.update_guess(guess)
    #masterAI.update_guess(board.feedback)
    #ai.read_output(board.feedback, index)
  else
    puts 'Log only four numbers between 1..8 each'
  end
  match = board.check_winner
  if board.full?
    puts "Game Over! Winning combination was: #{board.winning_position}"
    break
  end
  if match
    board.display
    #board.feedback
    puts "Hello, sir! You win! Winning combination was: #{board.winning_position}"
  end
end
