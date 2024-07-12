# make random colors but without duplicate

module RandomColor
  def random_colors
    [rand(1..2), rand(3..4), rand(5..6), rand(7..8)].shuffle!
  end
end
