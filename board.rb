require_relative 'random_colors'

class Board
  include RandomColor

  attr_reader :winning_position, :current_row

  def initialize
    @cells = Array.new(12) { Array.new(4, ' ') }
    @current_row = 0
    @winning_position = random_colors
    @feedback = Array.new(12) { Array.new(4, '-') }
  end

  def display
    @cells.each_with_index do |row, index|
        puts " #{row} feedback: #{@feedback[index]}"
        puts '---------------------'
    end
  end

  # def make_move(arr)
  #   if arr.size == 4 && arr.all? { |i| i.between?(1, 8) }
  #     @cells[@current_row] = arr
  #     @current_row += 1
  #   else
  #     false
  #   end
  #   false
  # end
  #
  def make_move(arr)
    if arr.size == 4 && arr.all? { |i| i.between?(1, 8) }
      feedback = calculate_feedback(arr)
      feedback(feedback)
      if feedback[0] == 4
        @cells[@current_row] = arr
        puts "Correct move! Feedback: #{feedback.join(' ')}"
        @current_row += 1
      else
        @cells[@current_row] = arr
        puts "Incorrect move. Feedback: #{feedback.join(' ')}"
        @current_row += 1
      end
    else
      false
    end
    false
  end

  def check_winner
    @winning_position == @cells[@current_row - 1]
  end

  # def feedback(arr)

  #   temp = []
  #   @cells[@current_row - 1].select.each_with_index do |item, index|
  #     if @winning_position[index] == item
  #       temp << 'X'
  #     elsif @winning_position.include?(item)
  #       temp << 'O'
  #     else
  #       temp << '-'
  #     end
  #   end
  #   @feedback[@current_row - 1] = temp.shuffle!
  # end
  #
  def feedback(arr)
    temp = []
    arr[0].times do
      temp << 'X'
    end
    arr[1].times do
      temp << 'O'
    end
    (4 - temp.size).times do
      temp << '-'
    end
    @feedback[@current_row] = temp.shuffle!
  end

  def calculate_feedback(guess)
    correct_positions = 0
    correct_colors = 0
    temp = []
    guess.each_with_index do |color, index|
      if @winning_position[index] == color
        correct_positions += 1
        temp << color
      end
    end
    diff = @winning_position - temp
    guess.each do |color|
      if diff.include?(color)
        correct_colors += 1
      end
    end
    [correct_positions, correct_colors]
  end

  def full?
    @current_row > 12
  end
end
