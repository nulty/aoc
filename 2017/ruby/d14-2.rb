input = "hwlqcszp"
# input = "flqrgnkx"

# Each row is a knot hash of length 128
# the knot hash outputs a 32 bit hex string
# convert each bit to binary
# count the number of 1 in the binary for each row

def hash(input)
  output = (0..255).to_a
  pos = skip = 0

  64.times do
    input.codepoints.concat([17, 31, 73, 47, 23]).each do |len|
      indexes = (pos..pos + len - 1).map { |i| i % output.length }
      values = indexes.map { |i| output[i] }.reverse
      indexes.each_with_index { |i, idx| output[i] = values[idx] }
      pos = (pos + skip + len) % output.length
      skip += 1
    end
  end

  output.each_slice(16).reduce(String.new) do |str, slice|
    substr = format("%.2x", slice.reduce(0, :^))
    binary = substr.chars.map { |c| format("%.4b", c.to_i(16)) }.join
    str.concat(binary)
  end
end

result = (0..127).map do |n|
  hash("#{input}-#{n}").tr("1", "#").tr("0", ".")
end

grid = result

# Super naive approach with iteration
# I wanted to write this with iteration instead of recursion
# Recursion is actually easier. This is first working draft.
# Make it work, make it good, make it fast.
#
# This also collects the size of each group
#
unseen = 0.upto(127).map { |i| 0.upto(127).map { |j| [i, j] } }.flat_map { |e| e }
return_to = []
groups = {}
group_id = 0
curr = [0, 0]

while true
  puts "curr: #{curr}"
  value = grid[curr[0]][curr[1]]
  unseen.delete([curr[0], curr[1]])

  # we enter a group here and don't leave until all neighbours are explored
  if value == "#"
    group_id += 1
    groups[group_id] ||= 0
    groups[group_id] += 1

    # look right, left up and down for connectiosn
    # ignore ones we've seen before
    [
      [curr[0] + 1, curr[1]],
      [curr[0] - 1, curr[1]],
      [curr[0], curr[1] + 1],
      [curr[0], curr[1] - 1]
    ].each do |x, y|
      # continue if we've never seen the idx before
      next unless unseen.include?([x, y])

      # if it's a hit, collect it
      if grid[x][y] == "#"
        # puts "found [#{x},#{y}]"
        groups[group_id] ||= 0
        groups[group_id] += 1
        return_to << [x, y]
      end
      unseen.delete([x, y])
    end
    while return_to.any?
      return_to.each do |rx, ry|
        [
          [rx + 1, ry],
          [rx - 1, ry],
          [rx, ry + 1],
          [rx, ry - 1]
        ].each do |x, y|
          # continue if we've never seen the idx before
          next unless unseen.include?([x, y])

          if grid[x][y] == "#"
            groups[group_id] ||= 0
            groups[group_id] += 1
            return_to << [x, y]
          end
          unseen.delete([x, y])
        end

        return_to.delete([rx, ry])
      end
    end
    break if unseen.empty?
  end

  curr = unseen.shift
  break if curr.nil?
end
puts groups
