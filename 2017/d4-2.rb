data = File.new("./inputs/d4.txt").read

puts data.lines.count { |phrase|
  sorted = phrase.chomp.split(" ").map { |w| w.chars.sort.join }
  sorted.size == sorted.uniq.size
}
