#! /usr/bin/env ruby

require "optparse"

SAMPLE_INPUT = 
"    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2"

# Construct options parser
parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename(__FILE__)} INPUT_FILE"
end
parser.parse!

# Use sample input if no input file provided
input = ARGV.empty? ? SAMPLE_INPUT : File.open(ARGV[0])

crates, _, moves = *input.each_line.chunk{ |l| l == "\n" }.map(&:last)

stacks = []
crates[0..-2].each do |line|
  row = line.chars.each_slice(4).map{ |a| a.join.strip }
  
  row.each_with_index do |c, i| 
    stacks[i] ||= []
    next if c.empty?
    
    stacks[i] << c[1]
  end
end
# puts stacks.inspect

# Deep copy stacks for part 2
stacks2 = stacks.map{ |s| s.clone }

moves.each do |move|
  count, src, dst = move.match(/(\d+).+(\d+).+(\d+)/)&.captures
  # puts "Move #{count} crates from stack #{src} to stack #{dst}"

  src = src.to_i - 1
  dst = dst.to_i - 1

  count.to_i.times do 
    c = stacks[src].shift
    stacks[dst].unshift(c)
    # puts stacks.inspect
  end
end

# Print part 1 answer
puts stacks.map { |s| s.first }.join

moves.each do |move|
  count, src, dst = move.match(/(\d+).+(\d+).+(\d+)/)&.captures
  # puts "Move #{count} crates from stack #{src} to stack #{dst}"

  src = src.to_i - 1
  dst = dst.to_i - 1

  c = stacks2[src].shift(count.to_i)
  stacks2[dst].unshift(c).flatten!
  #puts stacks2.inspect
end

# Print part 2 answer
puts stacks2.map { |s| s.first }.join
