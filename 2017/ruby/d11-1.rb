@steps = File.read("../inputs/d11.txt").chomp.split(",")

# @steps = "se,sw,se,sw,sw".split(",")
# @steps = "ne,ne,s,s".split(",")
# @steps = "ne,ne,ne".split(",")
# @steps = "ne,ne,sw,sw".split(",")

class Grid
  attr_reader :position

  def initialize
    @position = { q: 0, r: 0, s: 0 }
  end

  def move(direction)
    case direction
    when "ne"
      @position[:r] -= 1
      @position[:q] += 1
    when "sw"
      @position[:r] += 1
      @position[:q] -= 1
    when "nw"
      @position[:s] += 1
      @position[:q] -= 1
    when "se"
      @position[:q] += 1
      @position[:s] -= 1
    when "n"
      @position[:r] -= 1
      @position[:s] += 1
    when "s"
      @position[:r] += 1
      @position[:s] -= 1
    end
  end

  def distance
    @position.values.reduce(0) { |m, n| n.positive? ? n + m : m }
  end
end

def r
  @g = Grid.new
end

def g
  @g ||= Grid.new
end

@steps.each do |step|
  g.move(step)
end
puts g.position
puts g.distance
