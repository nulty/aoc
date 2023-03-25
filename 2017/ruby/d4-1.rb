# Passphrase

# A new system policy has been put in place that requires all accounts to use a
# passphrase instead of simply a password. A passphrase consists of a series of
# words (lowercase letters) separated by spaces.

# To ensure security, a valid passphrase must contain no duplicate words.

data = File.new("./inputs/d4.txt").read

puts data.lines.count { |phrase|
  phrase.chomp.split(/ /).size == phrase.chomp.split(/ /).uniq.size
}
