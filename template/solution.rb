#! /usr/bin/env ruby

require "optparse"

SAMPLE_INPUT = "test"

# Construct options parser
parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename(__FILE__)} INPUT_FILE"
end
parser.parse!

# Use sample input if no input file provided
input = ARGV.empty? ? SAMPLE_INPUT : File.open(ARGV[0])
