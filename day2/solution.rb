#!/usr/bin/env ruby


SCORES = {
  # Move
  :rock => 1,
  :paper => 2,
  :scissors => 3,
  # Results
  :lose => 0,
  :draw => 3,
  :win => 6,
}

PLAYS = {
  # Opponent plays
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors,
  # Responses
  "X" => :rock,
  "Y" => :paper,
  "Z" => :scissors,
}


def play_round(opponent, mine)
  delta = SCORES[mine] - SCORES[opponent]
  result = case delta
  when 0
    :draw
  when 1
    :win
  when -2
    :win
  else
    :lose
  end

  points = SCORES[mine] + SCORES[result]
  #puts "Mine: #{mine} vs Op: #{opponent} => Res: #{result} (#{delta}) Points: #{points}"
  points
end

SAMPLE_INPUT = "A Y
B X
C Z
"

# input = SAMPLE_INPUT
input = File.open("input")

total = input.each_line.map do |l|
  opponent, mine = l.strip.split(" ").map{|p| PLAYS[p]}
  play_round(opponent, mine)
end.sum

puts "Total Points: #{total}"

# Part2
PLAYS_PART2 = {
  # Opponent plays
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors,
  # Results
  "X" => :lose,
  "Y" => :draw,
  "Z" => :win,
}

BEATS = {
  # Move
  :rock => :scissors,
  :paper => :rock,
  :scissors => :paper,
}

def play_round2(opponent, result)
  
  mine = case result
  when :draw
    opponent
  when :win
    BEATS.key(opponent)
  when :lose
    BEATS[opponent]
  else
    raise "Oops #{result}"
  end

  points = SCORES[mine] + SCORES[result]
  # puts "Mine: #{mine} vs Op: #{opponent} => Res: #{result} Points: #{points}"
  points
end

input = File.open("input")
total2 = input.each_line.map do |l|
  opponent, result = l.strip.split(" ").map{|p| PLAYS_PART2[p]}
  play_round2(opponent, result)
end.sum

puts "Total Points 2: #{total2}"
