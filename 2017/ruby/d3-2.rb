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

  def first_total_above
    target = @input
    move_to_center
    set_curr_position(1)

    val = 1
    iteration = 1

    loop do
      if iteration.odd?
        move("right")
        val = sum_adjacent

        set_curr_position(val)
        break val if val > target

        iteration.times do
          move("up")
          val = sum_adjacent

          set_curr_position(val)
          break val if val > target
        end
        iteration.times do
          move("left")
          val = sum_adjacent

          set_curr_position(val)
          break val if val > target
        end
        break val if val > target
      else
        move("left")
        val = sum_adjacent

        set_curr_position(val)
        break val if val > target

        iteration.times do
          move("down")
          val = sum_adjacent

          set_curr_position(val)
          break val if val > target
        end
        iteration.times do
          move("right")
          val = sum_adjacent

          set_curr_position(val)
          break val if val > target
        end
        break val if val > target
      end
      iteration += 1
    end
    val
  end

  def fill
    move_to_center
    set_curr_position(1)

    val = 1

    iterations = Math.sqrt(@input).floor

    1.upto(iterations) do |iteration|
      if iteration.odd?
        move("right")
        set_curr_position(val += 1)
        iteration.times do
          move("up")
          set_curr_position(val += 1)
        end
        iteration.times do
          move("left")
          set_curr_position(val += 1)
        end
      else
        move("left")
        set_curr_position(val += 1)
        iteration.times do
          move("down")
          set_curr_position(val += 1)
        end
        iteration.times do
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
    iteration = 0

    Array.new(@grid_size) do
      Array.new(@grid_size) do
        if nils
          nil
        else
          format("%.#{@grid_size.to_s.length + 1}d", iteration = iteration.succ)
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
    iteration = 0
    char_width = @grid_size.to_s.length + 1
    @grid.each_with_index do |row, ridx|
      row.each_with_index do |col, cidx|
        val = if col.nil?
                iteration = iteration.succ
                nil
              else
                col
              end
        str = val ? format("%.#{char_width}d  ", val) : "-" * char_width + " "

        if ridx == @curr_row && cidx == @curr_col
          # str = "\033[1m#{str}\033[22m"
          str = "\033[34m#{str}\033[0m"
        end
        super(str)
      end
      puts
    end
  end

  # private

  attr_reader :input

  def curr_position
    @grid[@curr_row][@curr_col]
  end

  def set_curr_position(val)
    @grid[@curr_row][@curr_col] = val
  end

  def value_at(up: nil, down: nil, left: nil, right: nil)
    new_row = up || down || @curr_row
    new_col = right || left || @curr_col
    @grid[new_row][new_col] || 0
  end

  def sum_adjacent
    # right, up left, left, down, down, right, right
    right = @curr_col + 1
    left = @curr_col - 1
    up = @curr_row - 1
    down = @curr_row + 1
    directions = [
      { right: },
      { up:, right: },
      { up: },
      { up:, left: },
      { left: },
      { down:, left: },
      { down: },
      { down:, right: }
    ]

    directions.reduce(0) do |total, dir|
      total + value_at(**dir)
    end
  end

  def move_to_center
    @curr_row = @curr_col = center
  end

  def print_center_coords
    puts "@grid[#{center}][#{center}]"
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

# WRONG 371786
def g
  # @g = Grid.new(289326)
  @g ||= Grid.new(289_326, blank: true)
end

# res = 295229
