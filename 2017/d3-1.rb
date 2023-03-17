# Spiral Memory

# Produce a Spiral grid
#
# initialize the center point with 1
# and in a spiral initialize the remaining
# points incrementally
#
# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23  24  25
#
class Grid
  def initialize(input, blank: false)
    @input = input
    @grid = generate_grid(input, nils: blank)
    @curr_row = @curr_col = center
    move_to_center
  end

  def fill
    move_to_center
    set_curr_position(1)

    val = 1

    iterations = Math.sqrt(@input).floor

    1.upto(iterations) do |n|
      if n.odd?
        move("right")
        set_curr_position(val += 1)
        n.times do
          move("up")
          set_curr_position(val += 1)
        end
        n.times do
          move("left")
          set_curr_position(val += 1)
        end
      else
        move("left")
        set_curr_position(val += 1)
        n.times do
          move("down")
          set_curr_position(val += 1)
        end
        n.times do
          move("right")
          set_curr_position(val += 1)
        end
      end
    end
  end

  def generate_grid(input, nils: false)
    sqrt = Math.sqrt(input)
    sqrt_ceil = sqrt.ceil
    @grid_size = sqrt_ceil.odd? ? sqrt_ceil : sqrt_ceil.succ
    n = 0

    Array.new(@grid_size) do
      Array.new(@grid_size) do
        if nils
          nil
        else
          format("%.#{@grid_size.to_s.length + 1}d", n = n.succ)
        end
      end
    end
  end

  def find(val)
    @grid.each_with_index do |row, ri|
      row.each_with_index do |col, ci|
        return [ri, ci] if col == val
      end
    end
  end

  def distance(val)
    val_coords = find(val)
    (val_coords[0] - center).abs + (val_coords[1] - center).abs
  end

  def print
    n = 0
    @grid.each do |row|
      row.each do |col|
        val = col.nil? ? n = n.succ : col
        str = format("%.#{@grid_size.to_s.length + 1}d  ", val)
        super(str)
      end
      puts
    end
  end

  private

  attr_reader :input

  def curr_position
    @grid[@curr_row][@curr_col]
  end

  def set_curr_position(val)
    @grid[@curr_row][@curr_col] = val
  end

  def move_to_center
    @curr_row = @curr_col = center
  end

  def print_center_coords
    puts "@grid[#{center}]][#{center}]"
  end

  def move(direction)
    steps = 1
    case direction
    when /up/ then @curr_row -= steps
    when /down/ then @curr_row += steps
    when /left/ then @curr_col -= steps
    when /right/ then @curr_col += steps
    end
  end

  def coords
    puts "grid[#{@curr_row}][#{@curr_col}]"
  end

  def center
    @grid.length / 2
  end
end
