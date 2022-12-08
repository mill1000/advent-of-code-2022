#!/usr/bin/env ruby

# Sample input
# input = "1000
# 2000
# 3000

# 4000

# 5000
# 6000

# 7000
# 8000
# 9000

# 10000"

input = File.open("day1_part1_input")

cals = input.each_line.chunk{|l| l == "\n"}.map do |_b, a|
  a.map{ |s| s.strip.to_i }.reject{ |s| s == 0 }
end.reject{|a| a.empty?}.map{|a| a.sum}

puts "Max #{cals.max}"

sorted_cals = cals.sort.reverse
puts "Max 3 #{sorted_cals[0..2].sum}"
