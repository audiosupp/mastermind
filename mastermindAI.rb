class MastermindAI
  def initialize(colors, code_length)
    @colors = colors
    @code_length = code_length
    @possible_solutions = generate_possible_solutions
    @current_guess = initial_guess
  end

  def initial_guess
    @possible_solutions.sample
  end

  def update_guess(feedback)
    correct_positions, correct_colors = feedback
    @possible_solutions = update_possible_solutions(correct_positions, correct_colors)
    @current_guess = choose_next_guess
  end

  private

  def generate_possible_solutions
    @colors.repeated_permutation(@code_length).to_a
  end

  def update_possible_solutions(correct_positions, correct_colors)
    @possible_solutions.select do |solution|
      matches_feedback?(solution, correct_positions, correct_colors)
    end
  end

  def matches_feedback?(solution, correct_positions, correct_colors)
    correct_pos = 0
    correct_col = 0

    solution.each_with_index do |color, index|
      if solution[index] == @current_guess[index]
        correct_pos += 1
      elsif @current_guess.include?(color)
        correct_col += 1
      end
    end

    correct_pos == correct_positions && correct_col == correct_colors
  end

  def choose_next_guess
    if @possible_solutions.empty?
      nil # Return nil if no valid guess can be made
    else
      @possible_solutions.first
    end
  end
end
