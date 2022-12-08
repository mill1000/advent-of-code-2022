#! /usr/bin/env ruby

require "optparse"

SAMPLE_INPUT = "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8"

# Construct options parser
parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename(__FILE__)} INPUT_FILE"
end
parser.parse!

# Use sample input if no input file provided
input = ARGV.empty? ? SAMPLE_INPUT : File.open(ARGV[0])

ranges = input.each_line.map(&:strip).map do |line|
  first, second = line.split(",").map do |r|
    s, e = r.split("-").map(&:to_i)
    (s..e)
  end
  # puts "#{first} <-> #{second}"
  [first, second]
end

bad_ranges = ranges.map do |first, second|
  # Second covers first
  next true if second.cover?(first.first) && second.cover?(first.end)

  # First covers second
  next true if first.cover?(second.first) && first.cover?(second.end)

  next nil
end.compact

puts "Part 1: Number of bad ranges #{bad_ranges.length}"

any_overlap = ranges.map do |first, second|
  # Second covers first
  next true if second.cover?(first.first) || second.cover?(first.end)

  # First covers second
  next true if first.cover?(second.first) || first.cover?(second.end)

  next nil
end.compact

puts "Part 2: Number of overlap ranges #{any_overlap.length}"