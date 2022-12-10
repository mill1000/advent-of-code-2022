#! /usr/bin/env ruby

require "optparse"

SAMPLE_INPUT = "bvwbjplbgvbhsrlpgdmjqwftvncz"

# Construct options parser
parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename(__FILE__)} INPUT_FILE"
end
parser.parse!

# Use sample input if no input file provided
input = ARGV.empty? ? SAMPLE_INPUT : File.open(ARGV[0])

input.each_char.each_cons(4).with_index do |c, i|
  #puts c.inspect
  if c.uniq.length == 4
    puts i + 4
    break
  end
end

input.seek(0) if input.kind_of? File
input.each_char.each_cons(14).with_index do |c, i|
  #puts c.inspect
  if c.uniq.length == 14
    puts i + 14
    break
  end
end