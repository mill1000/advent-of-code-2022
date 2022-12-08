#!/usr/bin/env ruby

def get_priority(letter)
  case letter
  when 'a'..'z'
    letter.ord - 'a'.ord + 1
  when 'A'..'Z'
    letter.ord - 'A'.ord + 27
  else
    raise "Oops not letter"
  end
end

SAMPLE_INPUT = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"

# input = SAMPLE_INPUT
input = File.open("input")

priorities = input.each_line.map do |line|
  line.strip!
  mid = line.length / 2

  first, second = line[0..mid - 1], line[mid..-1]
  raise "Oops L1 != L2" unless first.length == second.length
  #puts "#{first} #{second}"
  
  common = first.chars.select{ |i| second.include?(i) }.first  
  #puts common

  get_priority(common)
end

total = priorities.sum

puts "Part 1 Total Priority: #{total}"

SAMPLE_INPUT2 = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"

# input = SAMPLE_INPUT2
input = File.open("input")
priorities2 = input.each_line.map(&:strip).each_slice(3).map do |slice|
  #puts slice.inspect
  one, two, three = slice
  common12 = one.chars.select{ |i| two.include?(i) }.uniq
  #puts common12.inspect

  common123 = common12.select{ |i| three.include?(i) }.uniq
  raise "Too many common" unless common123.length == 1

  get_priority(common123.first)
end

total2 = priorities2.sum
puts "Part 2 Total Priority: #{total2}"
